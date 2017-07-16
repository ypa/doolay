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

Create the VM:
```
cd ~/vagrant_boxes/dev/
vagrant up --provider=google
```

The rsync will failed because the base debian (jessie) image doesn't come with rsync installed.

Minimal manual provision steps on the box.
- Install rsync
```
vagrant ssh
sudo apt-get install rsync
```
- Create a vagrant user.
- Add your ~/.ssh/id_rsa.pub keys to vagrant user's ~/.ssh/authorized_keys on the VM.
- (optional) update vagrant user's ~/.bashrc aliases.
- (optional) Add vagrant user's ~/.vimrc file.

Exit out of VM and provision the box from vagrant. Back on your local:
```
vagrant provision --provision-with=shell
```

Once GCE VM is provisioned create an image from the VM instance.
https://cloud.google.com/compute/docs/images/create-delete-deprecate-private-images