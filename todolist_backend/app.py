from flask import Flask
from flask_cors import CORS  
from todo_routes import todo_bp
from weather_routes import weather_bp
from database import init_db

app = Flask(__name__)
CORS(app)  

# 注册蓝图
app.register_blueprint(todo_bp, url_prefix="/todo")
app.register_blueprint(weather_bp, url_prefix="/weather")

# 初始化数据库
init_db()

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
