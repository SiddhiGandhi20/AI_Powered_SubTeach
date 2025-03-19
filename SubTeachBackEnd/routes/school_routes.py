from flask import Blueprint, request, jsonify
from pymongo import MongoClient
from config import Config
from models.school_model import SchoolModel

# Create MongoDB connection inside routes
client = MongoClient(Config.MONGO_URI)
db = client[Config.DATABASE_NAME]

school_routes = Blueprint("school_routes", __name__)
school_model = SchoolModel(db)

# 🟢 GET SCHOOL PROFILE
@school_routes.route("/school", methods=["GET"])
def get_school():
    school = school_model.get_school()
    if school:
        school["_id"] = str(school["_id"])
        return jsonify({"success": True, "school": school}), 200
    return jsonify({"success": False, "message": "School profile not found"}), 404

# 🟢 CREATE SCHOOL PROFILE
@school_routes.route("/school", methods=["POST"])
def create_school():
    data = request.json
    school_id = school_model.create_school(data)
    
    if not school_id:
        return jsonify({"success": False, "message": "School profile already exists"}), 400

    return jsonify({"success": True, "message": "School profile created successfully", "school_id": str(school_id)}), 201

# 🟢 UPDATE SCHOOL PROFILE
@school_routes.route("/school", methods=["PUT"])
def update_school():
    data = request.json
    result = school_model.update_school(data)
    
    if result is None:
        return jsonify({"success": False, "message": "School profile not found"}), 404

    return jsonify({"success": True, "message": "School profile updated successfully"}), 200

# 🟢 DELETE SCHOOL PROFILE
@school_routes.route("/school", methods=["DELETE"])
def delete_school():
    result = school_model.delete_school()
    
    if result is None:
        return jsonify({"success": False, "message": "School profile not found"}), 404

    return jsonify({"success": True, "message": "School profile deleted successfully"}), 200
