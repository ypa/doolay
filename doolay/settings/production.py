import os
import dj_database_url
import django_cache_url

from .base import *

# Do not set SECRET_KEY, Postgres or LDAP password or any other sensitive data here.
# Instead, use environment variables or create a local.py file on the server.

# Disable debug mode
DEBUG = os.getenv('DJANGO_DEBUG', 'off') == 'on'
TEMPLATES[0]['OPTIONS']['debug'] = False

ALLOWED_HOSTS = [
    'localhost', '127.0.0.1', 'demo.doolay.com', 'staging.doolay.com'
]

# Compress static files offline and minify CSS
# http://django-compressor.readthedocs.org/en/latest/settings/#django.conf.settings.COMPRESS_OFFLINE
# COMPRESS_OFFLINE = True
COMPRESS_CSS_FILTERS = [
    'compressor.filters.css_default.CssAbsoluteFilter',
    'compressor.filters.cssmin.CSSMinFilter',
]
COMPRESS_CSS_HASHING_METHOD = 'content'

# Configuration from environment variables
# Alternatively, you can set these in a local.py file on the server

env = os.environ.copy()

# On Torchbox servers, many environment variables are prefixed with "CFG_"
for key, value in os.environ.items():
    if key.startswith('CFG_'):
        env[key[4:]] = value

# Basic configuration

APP_NAME = env.get('APP_NAME', 'doolay')


# Use Elasticsearch as the search backend for extra performance and better search results

WAGTAILSEARCH_BACKENDS = {
    'default': {
        'BACKEND': 'wagtail.search.backends.elasticsearch2',
        'INDEX': 'doolay',
    },
}

# Configure Elasticsearch, if present in os.environ
ELASTICSEARCH_ENDPOINT = os.getenv('ELASTICSEARCH_ENDPOINT', '')

if ELASTICSEARCH_ENDPOINT:
    from elasticsearch import RequestsHttpConnection
    WAGTAILSEARCH_BACKENDS = {
        'default': {
            'BACKEND': 'wagtail.search.backends.elasticsearch2',
            'HOSTS': [{
                'host': ELASTICSEARCH_ENDPOINT,
                'port': int(os.getenv('ELASTICSEARCH_PORT', '9200')),
                'use_ssl': os.getenv('ELASTICSEARCH_USE_SSL', 'off') == 'on',
                'verify_certs': os.getenv('ELASTICSEARCH_VERIFY_CERTS', 'off') == 'on',
            }],
            'OPTIONS': {
                'connection_class': RequestsHttpConnection,
            },
        }
    }


if 'SECRET_KEY' in env:
    SECRET_KEY = env['SECRET_KEY']

if 'PRIMARY_HOST' in env:
    BASE_URL = 'http://%s/' % env['PRIMARY_HOST']

if 'SERVER_EMAIL' in env:
    SERVER_EMAIL = env['SERVER_EMAIL']

if 'CACHE_PURGE_URL' in env:
    INSTALLED_APPS += ('wagtail.contrib.frontend_cache', )
    WAGTAILFRONTENDCACHE = {
        'default': {
            'BACKEND': 'wagtail.contrib.frontend_cache.backends.HTTPBackend',
            'LOCATION': env['CACHE_PURGE_URL'],
        },
    }

# Database

if 'DATABASE_URL' in os.environ:
    DATABASES = {'default': dj_database_url.config()}

else:
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql_psycopg2',
            'NAME': env.get('PGDATABASE', APP_NAME),
            'CONN_MAX_AGE':
            600,  # number of seconds database connections should persist for

            # User, host and port can be configured by the PGUSER, PGHOST and
            # PGPORT environment variables (these get picked up by libpq).
        }
    }

# Redis
# Redis place can either be passed through with REDIS_HOST or REDIS_SOCKET

# configure CACHES from CACHE_URL environment variable (defaults to locmem if no CACHE_URL is set)
CACHES = {'default': django_cache_url.config()}

# if 'REDIS_URL' in env:
#     REDIS_LOCATION = env['REDIS_URL']
#     BROKER_URL = env['REDIS_URL']
# 
# elif 'REDIS_HOST' in env:
#     REDIS_LOCATION = env['REDIS_HOST']
#     BROKER_URL = 'redis://%s' % env['REDIS_HOST']
# 
# elif 'REDIS_SOCKET' in env:
#     REDIS_LOCATION = 'unix://%s' % env['REDIS_SOCKET']
#     BROKER_URL = 'redis+socket://%s' % env['REDIS_SOCKET']
# 
# else:
#     REDIS_LOCATION = None
# 
# if REDIS_LOCATION is not None:
#     CACHES = {
#         'default': {
#             'BACKEND': 'django_redis.cache.RedisCache',
#             'LOCATION': REDIS_LOCATION,
#             'KEY_PREFIX': APP_NAME,
#             'OPTIONS': {
#                 'CLIENT_CLASS': 'django_redis.client.DefaultClient',
#             }
#         }
#     }


# Simplified static file serving.
# https://warehouse.python.org/project/whitenoise/

MIDDLEWARE.append('whitenoise.middleware.WhiteNoiseMiddleware')
STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'

if 'AWS_STORAGE_BUCKET_NAME' in os.environ:
    AWS_STORAGE_BUCKET_NAME = os.getenv('AWS_STORAGE_BUCKET_NAME')
    AWS_S3_CUSTOM_DOMAIN = '%s.s3.amazonaws.com' % AWS_STORAGE_BUCKET_NAME
    AWS_AUTO_CREATE_BUCKET = True

    INSTALLED_APPS.append('storages')
    MEDIA_URL = "https://%s/" % AWS_S3_CUSTOM_DOMAIN
    DEFAULT_FILE_STORAGE = 'storages.backends.s3boto3.S3Boto3Storage'

if 'GS_BUCKET_NAME' in os.environ:
    GS_BUCKET_NAME = os.getenv('GS_BUCKET_NAME')
    GS_PROJECT_ID = os.getenv('GS_PROJECT_ID')
    GS_DEFAULT_ACL = 'publicRead'
    GS_AUTO_CREATE_BUCKET = True

    INSTALLED_APPS.append('storages')
    DEFAULT_FILE_STORAGE = 'storages.backends.gcloud.GoogleCloudStorage'
    
# Logging

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'mail_admins': {
            'level': 'ERROR',
            'class': 'django.utils.log.AdminEmailHandler',
        },
    },
    'formatters': {
        'default': {
            'verbose':
            '[%(asctime)s] (%(process)d/%(thread)d) %(name)s %(levelname)s: %(message)s'
        }
    },
    'loggers': {
        'doolay': {
            'handlers': [],
            'level': 'INFO',
            'propagate': False,
            'formatter': 'verbose',
        },
        'wagtail': {
            'handlers': [],
            'level': 'INFO',
            'propagate': False,
            'formatter': 'verbose',
        },
        'django.request': {
            'handlers': ['mail_admins'],
            'level': 'ERROR',
            'propagate': False,
            'formatter': 'verbose',
        },
        'django.security': {
            'handlers': ['mail_admins'],
            'level': 'ERROR',
            'propagate': False,
            'formatter': 'verbose',
        },
    },
}

if 'LOG_DIR' in env:
    # doolay log
    LOGGING['handlers']['doolay_file'] = {
        'level': 'INFO',
        'class': 'cloghandler.ConcurrentRotatingFileHandler',
        'filename': os.path.join(env['LOG_DIR'], 'doolay.log'),
        'maxBytes': 5242880,  # 5MB
        'backupCount': 5
    }
    LOGGING['loggers']['wagtail']['handlers'].append('doolay_file')

    # Wagtail log
    LOGGING['handlers']['wagtail_file'] = {
        'level': 'INFO',
        'class': 'cloghandler.ConcurrentRotatingFileHandler',
        'filename': os.path.join(env['LOG_DIR'], 'wagtail.log'),
        'maxBytes': 5242880,  # 5MB
        'backupCount': 5
    }
    LOGGING['loggers']['wagtail']['handlers'].append('wagtail_file')

    # Error log
    LOGGING['handlers']['errors_file'] = {
        'level': 'ERROR',
        'class': 'cloghandler.ConcurrentRotatingFileHandler',
        'filename': os.path.join(env['LOG_DIR'], 'error.log'),
        'maxBytes': 5242880,  # 5MB
        'backupCount': 5
    }
    LOGGING['loggers']['django.request']['handlers'].append('errors_file')
    LOGGING['loggers']['django.security']['handlers'].append('errors_file')

try:
    from .local import *
except ImportError:
    pass
