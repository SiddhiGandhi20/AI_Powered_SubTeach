import os
from flask import Blueprint, request, jsonify, send_from_directory, url_for
from bson.objectid import ObjectId
from pymongo import MongoClient
from werkzeug.utils import secure_filename
from config import Config
from models.teacher_model import TeacherModel

# Create MongoDB connection inside routes
client = MongoClient(Config.MONGO_URI)
db = client[Config.DATABASE_NAME]

UPLOAD_FOLDER = "static/uploads"
ALLOWED_EXTENSIONS = {"png", "jpg", "jpeg", "gif"}
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

teacher_routes = Blueprint("teacher_routes", __name__)
teacher_model = TeacherModel(db)

# Get Teacher Profile
def allowed_file(filename):
    return "." in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

# Get Teacher Profile
@teacher_routes.route("/teacher/<teacher_id>", methods=["GET"])
def get_teacher(teacher_id):
    teacher = teacher_model.get_teacher(teacher_id)
    if teacher:
        teacher["_id"] = str(teacher["_id"])
        return jsonify({"success": True, "teacher": teacher}), 200
    return jsonify({"success": False, "message": "Teacher not found"}), 404

# Create Teacher Profile with Image Upload
@teacher_routes.route("/teacher", methods=["POST"])
def create_teacher():
    data = request.form.to_dict()
    
    # File Upload
    file = request.files.get("profile_photo")
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        filepath = os.path.join(UPLOAD_FOLDER, filename)
        file.save(filepath)
        data["profile_photo"] = url_for("static", filename=f"uploads/{filename}", _external=True)

    teacher_id = teacher_model.create_teacher(data)
    return jsonify({"success": True, "message": "Teacher created successfully", "teacher_id": str(teacher_id)}), 201

# Update Teacher Profile
@teacher_routes.route("/teacher/<teacher_id>", methods=["PUT"])
def update_teacher(teacher_id):
    data = request.form.to_dict()

    # Handle file upload
    file = request.files.get("profile_photo")
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        filepath = os.path.join(UPLOAD_FOLDER, filename)
        file.save(filepath)
        data["profile_photo"] = url_for("static", filename=f"uploads/{filename}", _external=True)

    result = teacher_model.update_teacher(teacher_id, data)
    if result.modified_count:
        return jsonify({"success": True, "message": "Teacher updated successfully"}), 200
    return jsonify({"success": False, "message": "No changes made"}), 400

# Delete Teacher Profile
@teacher_routes.route("/teacher/<teacher_id>", methods=["DELETE"])
def delete_teacher(teacher_id):
    result = teacher_model.delete_teacher(teacher_id)
    if result.deleted_count:
        return jsonify({"success": True, "message": "Teacher deleted successfully"}), 200
    return jsonify({"success": False, "message": "Teacher not found"}), 404

# 🟢 GET ALL TEACHERS
@teacher_routes.route("/teachers", methods=["GET"])
def get_all_teachers():
    teachers = teacher_model.get_all_teachers()
    for teacher in teachers:
        teacher["_id"] = str(teacher["_id"])
    return jsonify({"success": True, "teachers": teachers}), 200

# 🟢 SERVE PROFILE IMAGES
@teacher_routes.route("/uploads/<filename>")
def uploaded_file(filename):
    return send_from_directory(UPLOAD_FOLDER, filename)
