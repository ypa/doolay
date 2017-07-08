Google Compute Engine
=====================


## Install gcloud (the SDK)
```
cd Downloads/google-cloud-sdk/
./install.sh
gcloud init
echo -n 'ypa:' > /tmp/id_rsa.pub
cat ~/.ssh/id_rsa.pub >> /tmp/id_rsa.pub
less /tmp/id_rsa.pub
gcloud compute project-info add-metadata --metadata-from-file sshKeys=/tmp/id_rsa.pub
gcloud compute images list
```

## Create VM instance and image

These are the steps for creating GCE VM instances and images.


Use vagrant google plugin to spin up Google compute engine instance

From thinkpad as vagrant user:
```
sudo su vagrant
```

First add gce compatible vagrant box:
```
vagrant box add gce https://github.com/mitchellh/vagrant-google/raw/master/google.box
```

```
cd ~/vagrant_boxes/dev/
vagrant up --provider=google
```

if rsync failed, ssh to the gce VM just created and install rsync:
```
vagrant ssh
sudo apt-get install rsync
exit
```

Then back from Thinkpad run the provision:
```
vagrant provision --provision-with=shell
```

Once GCE VM is provisioned create an image from the VM instance.
https://cloud.google.com/compute/docs/images/create-delete-deprecate-private-images




