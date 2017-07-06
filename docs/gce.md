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

From thinkpad:

First add gce compatible vagrant box:
```
vagrant box add gce https://github.com/mitchellh/vagrant-google/raw/master/google.box
```

~/work/vagrant_gce_test/

vagrant up --provider=google
if rsync failed
vagrant ssh
sudo apt-get install rsync
exit

vagrant provistion --use shell


Once GCE VM is provisioned create an image from the VM instance.
https://cloud.google.com/compute/docs/images/create-delete-deprecate-private-images




