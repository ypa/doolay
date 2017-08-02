Release
=======
- [x] Sign up Google Cloud compute.
- [x] Create a google image via VM via vagrant as vagrant user (instead of ypa).
- [x] Test with gunicorn and nginx in Vagrant Virtualbox first.
- [ ] Fix Vagrantfile for default Virtualbox local deployments.
- [ ] Seperate db for dev settings and staging db and prod db.
- [ ] Configure Google VM to run app via gunicorn and nginx and make it publicly accessible.
- [ ] Update the vagrant/provision.sh (in gce branch) to do the gunicorn/nginx configuration auto.
- [ ] Convert vagrant/provision.sh shell provisioning into Ansible one.
- [ ] Update Vagrantfile to support both Virtualbox and Google providers.google for (coderwall vagrant and aws an active machine was found with a different provider)  
- [ ] Move media files to S3
- [ ] Deploy to GCE.
- [ ] Deploy staging and prod. (See TDD book)

Fixtures
========
- [x] Create fixtures out of the test hosts.
- [x] Continue testing prune_image_rendtions management command on mac mini.
- [x] Add a command in "demo" branch to delete wagtailimages Renditions.
- [x] Add it to provistion script to run it after load_initial_data command.
- [ ] Rename doolay/fixtures/db.json to initial_data.json


Production
==========
- [ ] Scout tour guides on the web and populate them as hosts.
- [ ] Stub out experiences from Urban Advantures/Vayable.
- [ ] Check out Airbnb.com/new


E-mail
======
- [ ] Add e-mail button on Host page.
- [ ] Add e-mail template form for sending inquiry e-mails.
- [ ] Research for Email forwarding (like craigslist)
- [ ] Research using send-grid as e-mail backend.
