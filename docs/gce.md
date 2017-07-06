Google Compute Engine
=====================

These are the steps for creating GCE VM instances and images.


Use vagrant google plugin to spin up Google compute engine instance

From thinkpad:
~/work/vagrant_gce_test/

vagrant up --provider=google
if rsync failed
vagrant ssh
sudo apt-get install rsync
exit

vagrant provistion --use shell


Once GCE VM is provisioned create an image from the VM instance.
https://cloud.google.com/compute/docs/images/create-delete-deprecate-private-images




