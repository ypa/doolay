from fabric.contrib.files import append, exists, sed
from fabric.api import env, local, run
import random


REPO_URL = 'git@github.com:ypa/doolay.git'
DEFAULT_ALLOWED_HOSTS = set(['demo.doolay.com', 'www.doolay.com'])
env.user = 'vagrant'


def deploy():
    site_folder = '/home/%s/sites/%s' % (env.user, env.host)
    source_folder = site_folder + '/source'

    _create_directory_structure_if_necessary(site_folder)
    _get_latest_source(source_folder)
    _update_settings(source_folder, env.host)
    _update_virtualenv(site_folder)
    # _update_static_files(source_folder)
    # _update_database(source_folder)

def _create_directory_structure_if_necessary(site_folder):
    for subfolder in ('media', 'static', 'source'):
        run('mkdir -p %s/%s' % (site_folder, subfolder))


def _get_latest_source(source_folder):
    if exists(source_folder + '/.git'):
        run('cd %s && git fetch' % (source_folder,))
    else:
        run('git clone %s %s' % (REPO_URL, source_folder))
    current_commit = local("git log -n 1 --format=%H", capture=True)
    run('cd %s && git reset --hard %s' % (source_folder, current_commit))


def _update_settings(source_folder, site_name):
    allowed_hosts = DEFAULT_ALLOWED_HOSTS
    allowed_hosts.add(site_name)
    settings_path = source_folder + '/doolay/settings/production.py'
    sed(settings_path, "DEBUG = True", "DEBUG = False")
    sed(settings_path,
        'ALLOWED_HOSTS =.+$',
        'ALLOWED_HOSTS = [%s]' % ', '.join('"{0}"'.format(host)
                                           for host in allowed_hosts)
    )
    secret_key_file = source_folder + '/doolay/secret_key.py'
    if not exists(secret_key_file):
        chars = 'abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)'
        key = ''.join(random.SystemRandom().choice(chars) for _ in range(50))
        append(secret_key_file, 'SECRET_KEY = "%s"' % (key,))
    append(settings_path, '\nfrom .secret_key import SECRET_KEY')


def _update_virtualenv(site_folder):
    virtualenv_folder = site_folder + '/../../.virtualenvs/doolay'
    if not exists(virtualenv_folder + '/bin/pip'):
        run('virtualenv --python=python3 %s' % (virtualenv_folder,))
    run('%s/bin/pip install -r %s/source/requirements.txt' % (
        virtualenv_folder, site_folder
    ))


def _update_static_files(source_folder):
    run('cd %s && ../virtualenv/bin/python manage.py collectstatic --noinput' % (
            source_folder,
    ))


def _update_database(source_folder):
    run(
        'cd %s && ../virtualenv/bin/python manage.py migrate --noinput' % (
            source_folder,
    ))
