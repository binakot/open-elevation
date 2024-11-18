from flask import Flask
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

from api.ver1.lookup import blueprint as ver1_lookup
from api.ver2.lookup import blueprint as ver2_lookup

app.register_blueprint(ver1_lookup, url_prefix='/api/v1')
app.register_blueprint(ver2_lookup, url_prefix='/api/v2')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=False)
