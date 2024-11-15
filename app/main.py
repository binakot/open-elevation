from flask import Flask
from flask_cors import CORS
import controllers.lookup_controller

app = Flask(__name__)
CORS(app)

if __name__ == '__main__':
    app.run(host='0.0.0.0')
