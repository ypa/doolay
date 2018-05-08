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

## Prepping for the VM


First as you (ypa user) update `vagrant_doolay_gce_base` repo's `Vagrantfile` with correct base image `install.sh` file.

On thinkpad the repo is checked out at `~/work/vagrant_doolay_gce_base`. Use wagtail's own `https://github.com/wagtail/vagrant-wagtail-base` as a reference.


## Create GCE VM instance as vagrant user
These are the steps for creating GCE VM instances and images.
Use vagrant google plugin to spin up Google compute engine instance.

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
# First sync up dir with repo
rsync -a /home/ypa/work/vagrant_doolay_gce_base/ ~/vagrant_boxes/dev/
cd ~/vagrant_boxes/dev/
vagrant up --provider=google # This could take a long long time (to establish connection with google)
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

## Connecting to demo/staging instance

```
ssh vagrant@staging.doolay.com
```

Or using gcloud command line client.

```
gcloud compute --project "findingmyanmar" ssh --zone "asia-southeast1-a" "demo-doolay-jessie-v3"
# then su to vagrant user
whoami
sudo su vagrant
whoami
 ```
