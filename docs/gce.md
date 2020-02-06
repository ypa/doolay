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

## Create base VM instance and image

These are the steps for creating GCE VM instances and images.
Use vagrant google plugin to spin up Google compute engine instance

### Prerequisites
Before the creating a vagrant instances do the following on Thinkpad as `ypa`:

```ssh
cd ~/vagrant_doolay_gce_base/
```
Check the `Vagrantfile` and check the `install/install.sh` files and make sure they're in the desired state.
Remember we' will be building a Vagrant base image that we could deploy our `doolay` app to with Vagrant.
Take a look at Wagtail repo:https://github.com/wagtail/vagrant-wagtail-base for reference. They tend to have different git branch for building different debian base images. On Thinkpad the wagtail's vagrant base repo was already cloned at `~/work/vagrant-wagtail-base/`. Just need to fetch the latest.

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
If the instanse is up successfully you can now use normally with vagrant commands:
```
vagrant ssh
vagrant halt
vagrant up
```

The above steps should also have known ssh `authorized_keys` copied over to instance's `~/.ssh/aurhorized_keys` location so that you can now login from Thinkpad or mac as ypa user: `ssh vagrant@<InstanceIP>`.

### Troubleshooting

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
## the folowing command can be obtained from GCP web console > VM instances's SSH dropdown
gcloud compute --project "findingmyanmar" ssh --zone "asia-southeast1-a" "demo-doolay-jessie-v3"
# then su to vagrant user
whoami
sudo su vagrant
whoami
 ```


### Bake the image
Bake the image so that you can now use it as a base image from doolay repo:

1. Stop the instance manually from GCP console web app.
2. Go to "Images" from console left nav.
3. Click "[+] CREATE IMAGE" at the top of the page.
4. Name the image such as `doolay-buster-v1` (this will be used from doolay's Vagrantfile).
5. Select source disk from the stopped VM, eg., `doolay-buster`.
6. (Optional) you can now delete the stopped base VM instance because are now ready to launch the real doolay VM instance from the base image!
