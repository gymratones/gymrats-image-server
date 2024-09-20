from PIL import Image
from io import BytesIO
import os


UPLOADS_LOCAL_FOLDER = os.path.join(os.getcwd(), 'server/uploads')
QUALITY = 100


class LocalStorage:
    def __init__(self):
        self.image_folder = UPLOADS_LOCAL_FOLDER
        if not os.path.exists(self.image_folder):
            os.makedirs(self.image_folder)

    def download_file(self, file_name):
        image_path = f'{self.image_folder}/{file_name}'
        if not os.path.exists(image_path):
            raise FileNotFoundError('Image not found')

        image = Image.open(image_path)
        buffer = BytesIO()
        image.save(buffer, format='JPEG')
        buffer.seek(0)

        return buffer

    def upload_file(self, file_name, image):
        image_path = f'{self.image_folder}/{file_name}'

        image.save(
            image_path,
            quality=QUALITY,
            optimize=True,
            progressive=True,
            mode="RGB"
        )

    def remove_file(self, file_name):
        image_path = f'{self.image_folder}/{file_name}'
        if not os.path.exists(image_path):
            raise FileNotFoundError('Image not found')

        os.remove(image_path)
