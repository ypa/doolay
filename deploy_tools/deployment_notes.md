Fabric Deployement (WIP)
=======================

### Code push to doolay staging
From the your own workstation or laptop push your changes and branch to Github.
Then run:
```
source ../environments/doolay_dev/bin/activate # on Mac mini to activate the virtual env 
cd deploy_tools
fab deploy:host=staging.doolay.com
```

### Restart gunicorn

ssh to the server:
```bash
YANs-Mac-mini:doolay ypa$ ssh vagrant@staging.doolay.com
```
On server restart the gunicorn. Since we already have the gunicorn systemd setup:
```bash
$ sudo systemctl restart gunicorn-doolay-staging
$ sudo systemctl status gunicorn-doolay-staging
```
