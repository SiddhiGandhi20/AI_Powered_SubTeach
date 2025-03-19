from bson.objectid import ObjectId

class SchoolModel:
    def __init__(self, db):
        self.collection = db["school"]

    # 🟢 GET SCHOOL PROFILE
    def get_school(self):
        return self.collection.find_one()

    # 🟢 CREATE SCHOOL PROFILE
    def create_school(self, data):
        if self.collection.count_documents({}) > 0:
            return None  # Prevent multiple school profiles
        return self.collection.insert_one(data).inserted_id

    # 🟢 UPDATE SCHOOL PROFILE
    def update_school(self, data):
        result = self.collection.update_one({}, {"$set": data})
        return result if result.modified_count > 0 else None

    # 🟢 DELETE SCHOOL PROFILE
    def delete_school(self):
        result = self.collection.delete_one({})
        return result if result.deleted_count > 0 else None
