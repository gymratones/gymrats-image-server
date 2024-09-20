from flask import Flask
from flask_restx import Api
from flask_cors import CORS
from config import Config

from imageserver.routes import root_namespace, images_namespace

app = Flask(__name__)
app.config.from_object(Config)
CORS(app)

api = Api(
    app,
    title='GymRats Image Server',
    version='1.0',
    description=f"<b>Repository:</b> https://github.com/gymratones/gymrats-image-server\n<b>StorageMode:</b> \"{app.config['STORAGE_MODE']}\"",
)

api.add_namespace(root_namespace, path='/v1')
api.add_namespace(images_namespace, path='/v1/images')
