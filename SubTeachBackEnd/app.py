from flask import Flask
from flask_cors import CORS
from routes.auth_routes import auth_bp
from routes.profile_routes import profile_bp
from routes.teacher_routes import teacher_routes
from utils.db_utils import init_db

app = Flask(__name__)
CORS(app)

# Initialize the database connection
init_db()

# Register blueprints
app.register_blueprint(auth_bp, url_prefix='/api/auth')
app.register_blueprint(profile_bp, url_prefix='/api/profile')
app.register_blueprint(teacher_routes, url_prefix="/api")

@app.route("/")
def home():
    return "Welcome to the Flask backend!"

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
