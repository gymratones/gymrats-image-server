import os


class Config:
    SECRET_KEY = os.getenv('SECRET_KEY')
    
    STORAGE_MODE = os.getenv('STORAGE_MODE', 'LOCAL_STORAGE')
    
    if STORAGE_MODE == 'LOCAL_STORAGE':
        pass
    if STORAGE_MODE == 'B2_STORAGE':
        B2_BUCKET_NAME = os.getenv('B2_BUCKET_NAME')
        B2_KEY_ID = os.getenv('B2_KEY_ID')
        B2_APPLICATION_KEY = os.getenv('B2_APPLICATION_KEY')


class Development(Config):
    DEBUG = True
    SECRET_KEY = os.getenv('SECRET_KEY') or 'clave'


class Testing(Config):
    TESTING = True


class Production(Config):
    pass


config = {
    'development': Development,
    'testing': Testing,
    'production': Production,
    'default': Development
}
