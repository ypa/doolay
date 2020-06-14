# Google Compute Engine

## GCE console

https://console.cloud.google.com/compute/instances?project=findingmyanmar

## Install GCloud SDK (one time only)

This is to be installed on your local workstation as a one time setup so that you can run gcloud commands to connect/setup/manage your VMs and other in GCE project.

Refer documentations on:
https://cloud.google.com/sdk/docs/quickstarts

## Create IAM service account (first time only)

```sh
gcloud iam service-accounts create doolay-ypa \
    --description="Yan P Aung" \
    --display-name="ypa"

## should see something like
# Created service account [doolay-ypa].
```

Add your public ssh key so that you can directly ssh to the instance from your terminal and also run ansible playbook.
Refer to this [page](https://cloud.google.com/compute/docs/instances/managing-instance-access) for more info on (optional) how to add SSH keys to accounts. This is so that you can directly ssh into the VM instances or running the playbook etc using your local PC's ssh keys.

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

### Provisioning the instance

Once VM is up and running mark down the public IP address.

1. Update the `ansible/inventroy/gce.yml` file for `gce_demo` entry's `ansible_host` filed.

2. Update the `ansible/playbook.yml` file `hosts` field at the top to `gce_demo`, so that when we run the playbook it'll provision the instance.
   You can test run a command by running ansible ad-hock command `ansible gce_demo -a "ls -la"`.

3. From your local terminal run the ansible playbook.

   ```sh
   ansible-playbook ansible/playbook.yml
   ```

   After the provision is done (took a few minutes), visit the root url of public IP (make sure to put trailing '/' in the url), you should see Nginx default page.

4. Once ansible-playbook provisioning is done, connect to VM instance (See below ways to connect to instance) and provision the VM with shell script for the rest.
5. As vagrant user setup ssh keys and add it to your github account
   ```sh
   sudo su vagrant
   whoami # should show vagrant
   # Follow the generating ssh key and adding it instructions on Github at: https://help.github.com/en/enterprise/2.15/user/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
   ```
6. Clone doolay repository into /tmp as vagrant user
   ```sh
   whoami # should show vagrant
   cd /tmp
   pwd # should show /tmp
   git clone git@github.com:ypa/doolay.git
   ls ./doolay # should show doolay repository contents
   # update ansible playbook to run locally
   # TODO: update this so that it can be run without editing on the GCE VM.
   cd ./doolay
   git status # should be on master
   ```
7. Sync `/vagrant` directory and copy code there
   ```sh
   rsync -ap /tmp/doolay/ /vagrant/
   ```
8. Provision/bootstrap the app by running shell provisioner
   ```sh
   sudo su # be root
   whoami # root
   cd /tmp/doolay/scripts/
   ./provision.sh doolay
   ```
9. The site should come online after the provision, and test it from your local by entering VM's public IP to your /etc/hosts demo.doolay.com.
10. If the site looks good, shut down the VM and update the instance's machine type back to `f1-micro (1 vCPU, 0.6 GB memory)` (**Important**) to save cost, then start it up again.
11. Test it again with the new IP by updating /etc/hosts demo.doolay.com on your local.

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
