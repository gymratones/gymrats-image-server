from flask import current_app
from b2sdk.v2 import InMemoryAccountInfo, B2Api
from b2sdk.v2.exception import FileNotPresent
from io import BytesIO


class B2Storage:
    def __init__(self):
        b2_bucket_name = current_app.config['B2_BUCKET_NAME']
        b2_key_id = current_app.config['B2_KEY_ID']
        b2_application_key = current_app.config['B2_APPLICATION_KEY']
        info = InMemoryAccountInfo()

        self.b2_api = B2Api(info)
        self.b2_api.authorize_account('production', b2_key_id, b2_application_key)
        self.bucket = self.b2_api.get_bucket_by_name(b2_bucket_name)

    def download_file(self, file_name):
        try:
            file_info = self.bucket.get_file_info_by_name(file_name)
            response = self.bucket.download_file_by_id(file_info.id_).response
            return BytesIO(response.content)
        except FileNotPresent:
            raise FileNotFoundError('Image not found')

    def upload_file(self, file_name, image):
        with BytesIO() as output:
            image.save(output, format="JPEG")
            data = output.getvalue()
            self.bucket.upload_bytes(file_name=file_name, data_bytes=data)

    def remove_file(self, file_name):
        try:
            file_info = self.bucket.get_file_info_by_name(file_name)
            self.bucket.delete_file_version(file_id=file_info.id_, file_name=file_name)
        except FileNotPresent:
            raise FileNotFoundError('Image not found')

        return "removed"
