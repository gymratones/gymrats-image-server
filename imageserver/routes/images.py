from flask import send_file, current_app
from flask_restx import Resource, Namespace, reqparse, abort
from PIL import Image
from werkzeug.datastructures import FileStorage

from imageserver.classes.LocalStorage import LocalStorage
from imageserver.classes.B2Storage import B2Storage


RESIZE_X = 150
RESIZE_Y = 150


images_namespace = Namespace(
    name='images',
    description='Namespace for images'
)


@images_namespace.route('/<string:file_name>')
class Images(Resource):

    parser = reqparse.RequestParser()
    parser.add_argument('file', location='files', type=FileStorage, required=True)

    def __init__(self, api):
        self.api = api
        self.storage_mode = current_app.config['STORAGE_MODE']

        if self.storage_mode == 'LOCAL_STORAGE':
            self.storage = LocalStorage()
        elif self.storage_mode == 'B2_STORAGE':
            self.storage = B2Storage()
        else:
            abort(409, 'STORAGE_MODE not defined properly')

    def get(self, file_name):
        """
        Retrieve an image
        """
        try:
            image = self.storage.download_file(file_name)
            return send_file(image, mimetype='image/jpeg')

        except FileNotFoundError as e:
            return {'message': str(e)}, 404
        except Exception as e:
            return {'message': str(e)}, 422

    @images_namespace.expect(parser)
    def post(self, file_name):
        """
        Add an image
        """
        try:
            args = self.parser.parse_args()
            file = args['file']

            image = Image.open(file.stream)
            original_width, original_height = image.size
            side = min(original_width, original_height)

            left = (original_width - side) / 2
            top = (original_height - side) / 2
            right = left + side
            bottom = top + side

            image = image.crop((left, top, right, bottom))
            image.thumbnail((RESIZE_X, RESIZE_Y))

            self.storage.upload_file(file_name, image)
            return {'message': 'Image uploaded'}, 201
        except Exception as e:
            return {'message': str(e)}, 422

    def delete(self, file_name):
        """
        Delete an image
        """
        try:
            self.storage.remove_file(file_name)
            return {'message': 'Image deleted'}, 204

        except FileNotFoundError as e:
            return {'message': str(e)}, 404
        except Exception as e:
            return {'message': str(e)}, 422
