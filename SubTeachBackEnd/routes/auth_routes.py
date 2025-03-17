from flask import Blueprint, request, jsonify
from werkzeug.security import generate_password_hash, check_password_hash
from models.user_model import users_collection

auth_bp = Blueprint('auth', __name__)

@auth_bp.route("/signup", methods=["POST"])
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
    users_collection.insert_one(user_data)

    return jsonify({"message": "Signup successful!"}), 201

@auth_bp.route("/login", methods=["POST"])
def login():
    data = request.get_json()
    email = data.get("email")
    password = data.get("password")

    if not email or not password:
        return jsonify({"error": "Missing email or password"}), 400

    user = users_collection.find_one({"email": email})

    if user and check_password_hash(user["password"], password):
        return jsonify({
            "message": "Login successful!",
            "name": user["name"],
            "role": user["role"]
        }), 200
    else:
        return jsonify({
            "toast": {
                "type": "error",
                "message": "The email or password you entered is incorrect. Please try again."
            }
        }), 401
