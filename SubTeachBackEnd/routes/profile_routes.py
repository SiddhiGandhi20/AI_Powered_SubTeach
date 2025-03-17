from flask import Blueprint, request, jsonify
from bson import ObjectId
from models.user_model import users_collection

profile_bp = Blueprint('profile', __name__)

@profile_bp.route("/<user_id>", methods=["GET"])
def get_profile(user_id):
    try:
        user = users_collection.find_one({"_id": ObjectId(user_id)})
        if user:
            return jsonify({
                "name": user["name"],
                "jobTitle": user.get("jobTitle", ""),
                "about": user.get("about", ""),
                "skills": user.get("skills", []),
                "certifications": user.get("certifications", []),
                "experiences": user.get("experiences", []),
                "availability": user.get("availability", {}),
                "reviews": user.get("reviews", [])
            }), 200
        else:
            return jsonify({"error": "User not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500