import django_heroku
import os

from .base import *

DEBUG = False

try:
    from .local import *
except ImportError:
    pass

django_heroku.settings(locals())