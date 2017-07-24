#!/bin/bash

PROJECT_NAME=$1

PROJECT_DIR=/vagrant
VIRTUALENV_DIR=/home/vagrant/.virtualenvs/$PROJECT_NAME

PYTHON=$VIRTUALENV_DIR/bin/python
PIP=$VIRTUALENV_DIR/bin/pip


# Create database
su - vagrant -c "createdb $PROJECT_NAME"


# Virtualenv setup for project
su - vagrant -c "virtualenv --python=python3 $VIRTUALENV_DIR"
# Replace previous line with this if you are using Python 2
# su - vagrant -c "virtualenv --python=python2 $VIRTUALENV_DIR"

su - vagrant -c "echo $PROJECT_DIR > $VIRTUALENV_DIR/.project"


# Upgrade PIP
su - vagrant -c "$PIP install --upgrade pip"

# Install PIP requirements
su - vagrant -c "$PIP install -r $PROJECT_DIR/requirements.txt"


# Set execute permissions on manage.py as they get lost if we build from a zip file
chmod a+x $PROJECT_DIR/manage.py


# Run syncdb/migrate/update_index
# Add $PYTHON $PROJECT_DIR/manage.py load_initial_data to load mock data on provision
su - vagrant -c "$PYTHON $PROJECT_DIR/manage.py makemigrations && \
				 $PYTHON $PROJECT_DIR/manage.py migrate --noinput && \
				 $PYTHON $PROJECT_DIR/manage.py load_initial_data &&\
				 $PYTHON $PROJECT_DIR/manage.py update_index"

# su - vagrant -c "psql -d $PROJECT_NAME -f $PROJECT_DIR/db/$PROJECT_NAME.sql && \
#                  $PYTHON $PROJECT_DIR/manage.py update_index"

# Configure nginx
su - vagrant -c "sed 's/SITENAME/staging.doolay.com/g' \
	$PROJECT_DIR/deploy_tools/nginx.template.conf | sudo tee \
	/etc/nginx/sites-available/staging.doolay.com && \
        sudo ln -s /etc/nginx/sites-available/staging.doolay.com \
        /etc/nginx/sites-enabled/staging.doolay.com"

# Gunicorn systemd script
su - vagrant -c "sed 's/SITENAME/staging.doolay.com/g' \
     $PROJECT_DIR/deploy_tools/gunicorn-doolay-SITENAME.service.template  | sudo tee \
     /etc/systemd/system/gunicorn-doolay-staging.service && \
     sudo systemctl enable gunicorn-doolay-staging"

# Code deployment
su - vagrant -c "mkdir -p /home/vagrant/sites/staging.doolay.com/source && \
	rsync -ap $PROJECT_DIR/ /home/vagrant/sites/staging.doolay.com/source/"

# Collect static files
su - vagrant -c "cd /home/vagrant/sites/staging.doolay.com/source/ && \
	export SECRET_KEY='mk2##cx8nq7r%ir_h$d8%(u_!5-nv4py4o6med8y%ux90*+)g2' && \
	$PYTHON manage.py collectstatic --settings doolay.settings.production --clear --noinput"

# Restart gunicorn and nginx
sudo systemctl start gunicorn-doolay-staging
sudo systemctl restart nginx


# Add a couple of aliases to manage.py into .bashrc
cat << EOF >> /home/vagrant/.bashrc
export PYTHONPATH=$PROJECT_DIR
export DJANGO_SETTINGS_MODULE=$PROJECT_NAME.settings.dev

alias dj="django-admin.py"
alias djrun="dj runserver 0.0.0.0:8000"

source $VIRTUALENV_DIR/bin/activate
export PS1="[$PROJECT_NAME \W]\\$ "
cd $PROJECT_DIR
EOF
