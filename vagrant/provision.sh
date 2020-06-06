#!/bin/bash

# Provision base image starts

# Update APT database
apt-get update -y

# Useful tools
apt-get install -y vim git curl gettext build-essential

# Dependencies for PIL
apt-get install -y libjpeg-dev libtiff-dev zlib1g-dev libfreetype6-dev liblcms2-dev

# Redis
apt-get install -y redis-server

# PostgreSQL
echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" > /etc/apt/sources.list.d/pgdg.list
cat /vagrant/vagrant/ACCC4CF8.asc | apt-key add
apt-get update -y
apt-get install -y postgresql-11 postgresql-client-11 postgresql-contrib-11 libpq-dev

# Java for Elasticsearch
apt install -y openjdk-8-jre-headless ca-certificates-java

# Remove Python 3.5 (shipped with debian)
# apt-get remove -y python3

# # Python 3.6
# apt-get install -y libssl-dev libncurses-dev liblzma-dev libgdbm-dev libsqlite3-dev libbz2-dev tk-dev libreadline6-dev
# curl https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz | tar xvz
# cd Python-3.6.4
# ./configure --enable-optimizations
# make
# make install
# cd ..
# rm -rf Python-3.6.4
# apt-get remove -y libssl-dev libncurses-dev liblzma-dev libgdbm-dev libsqlite3-dev libbz2-dev tk-dev libreadline6-dev


# Install pip3
apt-get install -y python3-pip

# Install poetry and Fabric
pip3 install poetry Fabric

# We need virtualenv >13.0.0 in order to get pip 7 to automatically install
pip3 install virtualenv


# Create vagrant pgsql superuser
su - postgres -c "createuser -s vagrant"


# Elasticsearch
echo "Downloading Elasticsearch..."
wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.8.deb
dpkg -i elasticsearch-5.6.8.deb
# reduce JVM heap size from 2g to 512m
sed -i 's/^\(-Xm[sx]\)2g$/\1512m/g' /etc/elasticsearch/jvm.options

systemctl enable elasticsearch
systemctl start elasticsearch
rm elasticsearch-5.6.8.deb


# Remove packages that we don't need
apt-get autoremove -y

# Remove Python tests pycache (only used for testing Python itself. Saves 29.5MB)
rm -rf /usr/local/lib/python3.6/test/__pycache__

# Cleanup
apt-get clean

echo "Zeroing free space to improve compression..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY








# Provistion for doolay starts

PROJECT_NAME=$1

PROJECT_DIR=/vagrant
VIRTUALENV_DIR=/home/vagrant/.virtualenvs/$PROJECT_NAME

PYTHON=$VIRTUALENV_DIR/bin/python
PIP=$VIRTUALENV_DIR/bin/pip

# Update repos
apt-get update

# Install nginx
apt-get install -y nginx
systemctl enable nginx

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

# Untar fixture images
su - vagrant -c "tar -zxvf $PROJECT_DIR/doolay/fixtures/images.tar.gz \
	               -C $PROJECT_DIR/doolay/fixtures/"

# Run syncdb/migrate/update_index
# Add $PYTHON $PROJECT_DIR/manage.py load_initial_data to load mock data on provision
su - vagrant -c "$PYTHON $PROJECT_DIR/manage.py makemigrations && \
				 $PYTHON $PROJECT_DIR/manage.py migrate --noinput && \
				 $PYTHON $PROJECT_DIR/manage.py load_initial_data && \
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

# Prepare Media files
su - vagrant -c "mkdir -p /home/vagrant/sites/staging.doolay.com/media/original_images && \
        tar -zxvf $PROJECT_DIR/doolay/fixtures/images.tar.gz \
	    -C /home/vagrant/sites/staging.doolay.com/media/original_images/ --strip-components=1"

# Collect static files
su - vagrant -c "cd /home/vagrant/sites/staging.doolay.com/source/ && \
	export SECRET_KEY='mk2##cx8nq7r%ir_h$d8%(u_!5-nv4py4o6med8y%ux90*+)g2' && \
	$PYTHON manage.py collectstatic --settings doolay.settings.production --clear --noinput"

# Run custom developed command for cleaning up image renditions
su - vagrant -c "cd /home/vagrant/sites/staging.doolay.com/source/ && \
	export SECRET_KEY='mk2##cx8nq7r%ir_h$d8%(u_!5-nv4py4o6med8y%ux90*+)g2' && \
	$PYTHON manage.py cleanup_wagtailimage_renditions --settings doolay.settings.production"

# Restart gunicorn and nginx
sudo systemctl start gunicorn-doolay-staging
sudo systemctl restart nginx


# Add a couple of aliases to manage.py into .bashrc
cat << EOF >> /home/vagrant/.bashrc
export PYTHONPATH=$PROJECT_DIR
export DJANGO_SETTINGS_MODULE=$PROJECT_NAME.settings.dev

alias ll="ls -l"
alias dj="django-admin.py"
alias djrun="dj runserver 0.0.0.0:8000"

source $VIRTUALENV_DIR/bin/activate
export PS1="[$PROJECT_NAME \W]\\$ "
cd $PROJECT_DIR
EOF
