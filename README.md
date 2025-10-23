# 校园生活桌面宠物助手 🐱

> 陪伴你学习的智能桌面宠物，帮你管理DDL、提醒考试、规划学习


## 📖 项目简介

校园助手桌宠是一个面向大学生的桌面助手应用，通过可爱的桌面宠物形式，帮助学生：
- 📝 管理作业DDL和考试安排
- ⏰ 智能提醒重要日程
- 🤖 AI助手陪伴学习
- 😊 根据任务情况展现不同情绪

**核心特性**：
- ✅ 零成本：完全免费，采用本地模型
- ✅ 隐私保护：数据本地存储，离线可用
- ✅ 跨平台：支持Windows/macOS/Linux

### 技术栈

| 模块 | 技术 | 说明 |
|------|------|------|
| **桌宠** | Godot 4.5 | 游戏引擎，2D动画 |
| **后端** | Flask + SQLite | 轻量Web框架 + 本地数据库 |
| **前端** | Vue3 + Element Plus | 设置面板UI |
| **AI** | LangChain | 本地小模型（1.3GB） |
| **通信** | WebSocket + REST API | 实时通信 + 数据交互 |

## 🎯 核心功能

### 1. DDL管理
- 添加/编辑/删除作业DDL
- 导入课程表
- 按紧急度分级（红/橙/黄/绿）
- 完成后庆祝动画

### 2. 智能提醒
- 考试提前提醒
- DDL临近通知
- 渐进式提醒（徽章→气泡→声音→桌面通知）

### 3. AI助手
- 自然语言查询："下周有什么DDL？"
- 学习计划生成："帮我规划复习"
- 简单对话陪伴

### 4. 情绪表达
- 😊 开心：无DDL或刚完成任务
- 😐 平静：正常状态
- 😟 担忧：DDL 1-3天
- 😫 焦虑：DDL <24小时或多DDL
- 😴 困倦：夜晚时段

---

## 🔧 开发指南

### 分支管理
```
main          # 生产分支
develop       # 开发分支
feature/*     # 功能分支
bugfix/*      # Bug修复分支
```

### 提交规范
```
feat: 新功能
fix: Bug修复
docs: 文档更新
style: 代码格式
refactor: 重构
test: 测试
chore: 构建/工具
```


## 📊 开发进度

- [x] Week 1: 基础框架搭建
- [ ] Week 2: 模块对接
- [ ] Week 3-4: 核心功能开发
- [ ] Week 5-6: AI功能集成
- [ ] Week 7: 测试和优化
- [ ] Week 8: 打包交付

## 🤝 贡献指南

1. Fork本仓库
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'feat: Add AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 提交Pull Request

## 🔗 相关链接

- [Godot官方文档](https://docs.godotengine.org)
- [Flask文档](https://flask.palletsprojects.com)
- [Vue3文档](https://vuejs.org)
- [LangChain文档](https://python.langchain.com)

test