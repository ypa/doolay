Google Compute Engine
=====================

## GCE console
https://console.cloud.google.com/compute/instances?project=findingmyanmar

## Install gcloud (the SDK)
```sh
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
```sh
sudo su vagrant
```

First add gce compatible vagrant box:
```sh
vagrant box add gce https://github.com/mitchellh/vagrant-google/raw/master/google.box
```

Create the VM:
```sh
# First sync up dir with repo
rsync -a /home/ypa/work/vagrant_doolay_gce_base/ ~/vagrant_boxes/dev/
cd ~/vagrant_boxes/dev/
vagrant up --provider=google # This could take a long long time (to establish connection with google)
```

If you see the rsyc failing it is because the base debian (jessie) image doesn't come with rsync installed.

Do the manual provision steps on the box by ssh'ing into it:
1. Install rsync
```sh
vagrant ssh
sudo apt-get install rsync
```
2. Create a vagrant user.
3. Add your ~/.ssh/id_rsa.pub keys to vagrant user's ~/.ssh/authorized_keys on the VM.
4. (optional) update vagrant user's ~/.bashrc aliases.
5. (optional) Add vagrant user's ~/.vimrc file.
6. 

Exit out of VM and provision the box from vagrant. Back on your local:
```sh
vagrant provision --provision-with=shell
```
Once GCE VM is provisioned create an image from the VM instance.
https://cloud.google.com/compute/docs/images/create-delete-deprecate-private-images


## Connecting to demo/staging instance

```sh
ssh vagrant@staging.doolay.com
```

Or using gcloud command line client.

```sh
gcloud compute --project "findingmyanmar" ssh --zone "asia-southeast1-a" "demo-doolay-jessie-v3"
# then su to vagrant user
whoami
sudo su vagrant
whoami
 ```
