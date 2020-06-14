# Google Compute Engine

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

## Create IAM service account (first time only)

```sh
gcloud iam service-accounts create doolay-ypa \
    --description="Yan P Aung" \
    --display-name="ypa"

## should see something like
# Created service account [doolay-ypa].
```

Add your public ssh key so that you can directly ssh to the instance from your terminal and also run ansible playbook.
Step 5 on this [page](https://cloud.google.com/compute/docs/instances/managing-instance-access).

```sh
gcloud compute os-login ssh-keys add \
    --key-file ~/.ssh/id_rsa.pub \
    --ttl 30d    # 30 days
```

## Creating and Provisioning the Compute Engine VM Instance

### Create VM instance from Google Cloud console

1. Login to google cloud console from url: https://console.cloud.google.com/

- Username: yan.pye.aung@gmail.com
- Pwd:

2. Click on Compute Engine.
3. Create Instance.
4. Enter name of the instance for example: `doolay-demo-buster64`.
5. Select Region `europe-west3 (Frankfurt)` and Zone `europe-west3-b`. The reason is more Europeans visit Myanmar and we want them to have a snappy connection to our site.
6. Select Boot disk: `Debian GNU/Linux 10 (buster)`.
7. Under Identity and API access, select Service Account `ypa` created in above step.
8. Under Firewall Check `Allow HTTP traffic` and `Allow HTTPS traffic`.
9. Click Create. It'll take a few minutes for the instance to start up and you'll see the green check mark.

**Note**: Keep Machine type `n1-standard-1 (1 vCPU, 3.75GB memory)` during provisioning then change it to something else like `f1-micro` later.

### Provision the VM instance

#### Connecting the instance

Once the VM instance is created you can ssh into it directly from the browser or from gcloud SDK command (if you set it up with ssh keys in above steps).

1. From the browser logged in to Google Cloud console click on SSH dropdown. Then click gcloud command line.
   You'll see a command like, for example: `gcloud beta compute ssh --zone "europe-west3-b" "doolay-demo-buster64" --project "findingmyanmar"`
2. Copy the command and paste it in your terminal where you had previously setup your ssh public keys.
   You might have to re-auth with OAuth again: `gcloud auth login` if asked. Do that.
3. SSH directly from your terminal since you've added ssh key in one of the above steps at the top.
   ```sh
   ssh yan_pye_aung_gmail_com@<public_ip_address>
   ```

### Provisioning the instance

Once you're on the VM instance manully install these packages so that you can run provisioner scripts to bootstrap the app.

1. Install base software packages as root user.
   ```sh
   cd /tmp/
   sudo su
   apt update
   apt install -y git rsync python3-pip
   pip3 install ansible
   ```
2. Add `vagrant` user
   ```sh
   adduser vagrant
   # when prompted for psswrd use: V...
   ```
3. As vagrant user setup ssh keys and add it to your github account
   ```sh
   su vagrant
   whoami
   # Follow the generating ssh key and adding it instructions on Github at: https://help.github.com/en/enterprise/2.15/user/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
   ```
4. Clone doolay repository into /tmp as vagrant user
   ```sh
   whoami # should show vagrant
   pwd # should show /tmp
   git clone git@github.com:ypa/doolay.git
   ls ./doolay # should show doolay repository contents
   # update ansible playbook to run locally
   # TODO: update this so that it can be run without editing on the GCE VM.
   cd ./doolay
   vim ./ansible/playbook.yml
   git diff
   -- hosts: all
   +- hosts: 127.0.0.1
   +  connection: local
   tasks:
     - name: Install useful tools
       apt:
   ```
5. Provision the base VM with ansible playbook as original sudo user
   ```sh
   exit # out of vagrant and be root
   whoami # root
   exit
   whoami # yan_pye_aung_gmail_com
   ansible-playbook /tmp/doolay/ansible/playbook.yml
   ```
6. Sync `/vagrant` directory and copy code there
   ```sh
   sudo su # back to root
   rsync -ap /tmp/doolay/ /vagrant/
   ```
7. Provision/bootstrap the app by running shell provisioner
   ```sh
   whoami # yan_pye_aung_gmail_com
   cd /tmp/doolay/scripts/
   sudo ./provision.sh doolay
   ```
8. The site should come online after the provision, and test it from your local by entering VM's public IP to your /etc/hosts dev.doolay.com.
9. If the site looks good, shut down the VM and update the instance's machine type back to `f1-micro (1 vCPU, 0.6 GB memory)` (**Important**) to save cost, then start it up again.
10. Test it again with the new IP by updating /etc/hosts dev.doolay.com on your local.
