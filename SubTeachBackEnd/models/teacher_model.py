from bson.objectid import ObjectId

class TeacherModel:
    def __init__(self, db):
        self.collection = db["teachers"]

    def get_teacher(self, teacher_id):
        return self.collection.find_one({"_id": ObjectId(teacher_id)})

    def create_teacher(self, data):
        teacher_data = {
            "name": data.get("name"),
            "email": data.get("email"),
            "subject": data.get("subject"),
            "experience": data.get("experience"),
            "qualification": data.get("qualification"),
            "certifications": data.get("certifications", []),
            "availability": data.get("availability", True),
            "profile_photo": data.get("profile_photo", "")
        }
        result = self.collection.insert_one(teacher_data)
        return result.inserted_id

    def update_teacher(self, teacher_id, data):
        update_data = {key: value for key, value in data.items() if value is not None}
        return self.collection.update_one({"_id": ObjectId(teacher_id)}, {"$set": update_data})

    def delete_teacher(self, teacher_id):
        return self.collection.delete_one({"_id": ObjectId(teacher_id)})

    def get_all_teachers(self):
        return list(self.collection.find())
