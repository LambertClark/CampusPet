from flask import Blueprint, request, jsonify
from database import db
from models.todo import Todo

todo_bp = Blueprint("todo", __name__)

# 获取全部任务
@todo_bp.route("/", methods=["GET"])
def get_all():
    todos = Todo.query.all()
    return jsonify([t.to_dict() for t in todos])

# 添加任务
@todo_bp.route("/", methods=["POST"])
def create_todo():
    data = request.get_json()
    new_todo = Todo(title=data["title"], description=data.get("description", ""))
    db.session.add(new_todo)
    db.session.commit()
    return jsonify({"message": "Task added successfully."}), 201

# 更新任务
@todo_bp.route("/<int:todo_id>", methods=["PUT"])
def update_todo(todo_id):
    todo = Todo.query.get(todo_id)
    if not todo:
        return jsonify({"error": "Task not found"}), 404

    data = request.get_json()
    todo.title = data.get("title", todo.title)
    todo.description = data.get("description", todo.description)
    todo.is_done = data.get("is_done", todo.is_done)
    db.session.commit()
    return jsonify(todo.to_dict())

# 删除任务
@todo_bp.route("/<int:todo_id>", methods=["DELETE"])
def delete_todo(todo_id):
    todo = Todo.query.get(todo_id)
    if not todo:
        return jsonify({"error": "Task not found"}), 404
    db.session.delete(todo)
    db.session.commit()
    return jsonify({"message": "Task deleted."})
