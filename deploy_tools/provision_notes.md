Provisioning a new site
=======================

Once VM is up and running via vagrant up command, we need to bootstrap nginx conf for staging or production site as reverse proxy for gunicorn app running the django site.


1. SSH to the VM:

```
vagrant ssh
```
2. Once you're on VM install nginx conf files.
```
[doolay vagrant]$ whoami
vagrant
[doolay vagrant]$ pwd
/vagrant
[doolay vagrant]$ sed "s/SITENAME/staging.doolay.com/g" \
>    deploy_tools/nginx.template.conf | sudo tee \
>    /etc/nginx/sites-available/staging.doolay.com
[doolay vagrant]$ sudo ln -s /etc/nginx/sites-available/staging.doolay.com \
>    /etc/nginx/sites-enabled/staging.doolay.com
```
3. Install the Gunicorn systemd start up script so that the app would run on shutdown and startup
```
[doolay vagrant]$ sed "s/SITENAME/staging.doolay.com/g" \
>     deploy_tools/gunicorn-doolay-SITENAME.service.template  | sudo tee \
>     /etc/systemd/system/gunicorn-doolay-staging.service
```
4. Enable the gunicorn systemd service
```
[doolay vagrant]$ sudo systemctl enable gunicorn-doolay-staging
```


Code Deployment
===============
Copy the contents of /vagrant into vagrant user's home sites dir.
```
[doolay vagrant]$ mkdir -p /home/vagrant/sites/staging.doolay.com/source
[doolay vagrant]$ rsync -ap /vagrant/ /home/vagrant/sites/staging.doolay.com/source/
```
Start gunicorn and nginx
```
[doolay vagrant]$ sudo systemctl start gunicorn-doolay-staging
[doolay vagrant]$ sudo systemctl start nginx
```

Now visit localhost:8080 which wis being forwarded in Vagrantfile. You should see the site.




