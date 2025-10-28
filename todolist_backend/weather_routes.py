from flask import Blueprint, jsonify
import requests

weather_bp = Blueprint("weather", __name__)

# 示例API，之后替换为真实API Key
API_KEY = "API_KEY"
BASE_URL = "https://api.open-meteo.com/v1/forecast"

@weather_bp.route("/<city>", methods=["GET"])
def get_weather(city):
    # 这里可以使用真实的城市坐标
    params = {
        "latitude": 35.0,
        "longitude": 139.0,
        "current_weather": True
    }
    response = requests.get(BASE_URL, params=params)
    data = response.json()
    current = data.get("current_weather", {})

    return jsonify({
        "city": city,
        "temperature": f"{current.get('temperature', 'N/A')}°C",
        "windspeed": current.get("windspeed", "N/A"),
        "description": "Sunny" if current.get("temperature", 0) > 20 else "Cloudy"
    })
