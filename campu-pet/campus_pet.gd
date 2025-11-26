@tool # 允许在编辑器中预览随机行为
extends Node2D

# --- 变量声明 ---
# 使用 @onready 确保在节点进入场景树后才获取引用
@onready var pet_sprite = $PetSprite
@onready var animation_player = $AnimationPlayer

# 桌宠的状态
var current_state = "idle" 
# 行走速度（像素/秒）
var walk_speed = 80
# 移动方向：1 代表向右，-1 代表向左
var direction = 1
# 计时器，用于控制状态切换
var state_timer = 0.0
# 状态持续时间（秒）
var idle_duration = 3.0
var walk_duration = 5.0

# --- 函数 ---
func _ready():
	# 初始化随机数种子
	randomize()
	
	var screen_size = DisplayServer.screen_get_size()
	var window_size = get_window().size
	
	# 计算窗口左上角坐标，使其出现在屏幕右下角（留一点边距）
	var target_pos = Vector2(
		screen_size.x - window_size.x - 20,  # 右侧边距 20px
		screen_size.y - window_size.y - 60   # 底部边距 60px（避开任务栏）
	)
	# 设置窗口位置
	get_window().position = target_pos
	# 设置宠物初始位置为窗口中心（可选）
	position = Vector2(window_size.x / 2, window_size.y * 0.8)
	# 设置初始动画
	update_animation()
	# 随机设置初始方向
	direction = [1, -1][randi() % 2]
	# 随机设置初始状态和计时器
	if randf() < 0.5:
		current_state = "idle"
		state_timer = randf_range(1.0, idle_duration)
	else:
		current_state = "walking"
		state_timer = randf_range(1.0, walk_duration)
		# 如果一开始就在行走，确保动画播放
		if pet_sprite.animation == "idle":
			pet_sprite.play("walk")

func _process(delta):
	# 更新状态计时器
	state_timer -= delta
	
	match current_state:
		"idle":
			# 待机状态下，计时器归零后开始行走
			if state_timer <= 0:
				start_walking()
		"walking":
			# 行走状态下，移动角色
			move_and_constrain(delta)
			# 计时器归零后回到待机
			if state_timer <= 0:
				start_idle()
	
	# 每帧都更新动画（处理方向翻转）
	update_animation()

func move_and_constrain(delta):
	# 根据方向和速度计算移动量
	var move_x = walk_speed * delta * direction
	position.x += move_x
	
	# 获取当前窗口的大小
	var window_size = get_viewport_rect().size
	# 边界检测：如果超出左右边界，则转向
	if position.x < 0:
		position.x = 0
		direction = 1
	elif position.x > window_size.x:
		position.x = window_size.x
		direction = -1

func update_animation():
	# 根据方向翻转精灵图像
	pet_sprite.flip_h = direction < 0

func start_walking():
	current_state = "walking"
	state_timer = walk_duration
	pet_sprite.play("walk")

func start_idle():
	current_state = "idle"
	state_timer = idle_duration
	pet_sprite.play("idle")

# 可选：添加鼠标点击交互
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# 获取 AnimatedSprite2D 的全局包围盒
		var rect = get_pet_global_rect()
		if rect.has_point(event.position):
			start_idle()
			print("喵！别摸我！")

# 新增函数：计算宠物的全局点击区域
func get_pet_global_rect() -> Rect2:
	var sprite = pet_sprite
	if not sprite.texture:
		return Rect2()
	
	# 获取原始纹理大小
	var tex_size = sprite.texture.get_size()
	# 考虑缩放（注意：如果 flip_h 为 true，scale.x 可能是负数）
	var abs_scale = Vector2(abs(sprite.scale.x), abs(sprite.scale.y))
	var scaled_size = tex_size * abs_scale
	
	# 计算左上角（考虑锚点，默认中心）
	var offset = -scaled_size / 2  # 因为 AnimatedSprite2D 默认以中心为原点
	
	# 全局位置 = 节点全局位置 + 偏移
	var global_pos = sprite.global_position + offset
	
	return Rect2(global_pos, scaled_size)
