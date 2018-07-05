import os

ENV = os.environ.get('ENV', 'dev')

if ENV == 'dev':
    from .dev import *
elif ENV == 'prod':
    from .production import *