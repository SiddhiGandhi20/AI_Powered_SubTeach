from flask import Blueprint, request, jsonify
from werkzeug.security import generate_password_hash
from models.user_model import users_collection

signup_bp = Blueprint('signup', __name__)

@signup_bp.route("/signup", methods=["POST"])
def signup():
    data = request.get_json()
    required_fields = ["name", "email", "password", "role"]
    for field in required_fields:
        if field not in data:
            return jsonify({"error": f"Missing {field}"}), 400

    name = data["name"]
    email = data["email"]
    password = data["password"]
    role = data["role"]

    hashed_password = generate_password_hash(password)

    user_data = {
        "name": name,
        "email": email,
        "password": hashed_password,
        "role": role,
    }
    result = users_collection.insert_one(user_data)

    return jsonify({"message": "Signup successful!", "schoolId": str(result.inserted_id)}), 201
