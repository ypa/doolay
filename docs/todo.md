Site
====
- [x] Create Repo
- [x] Install Wagtail CMS from beginner cookie cutter
- [x] Transform people app to hosts (strip it down to simpler model)
- [x] Statuses should be Interests
- [x] Transform skills app to experiences (make this more like people model)
- [x] Connect Hosts and Experiences for one to many relations. Make sure the relationship is right.
- [x] Vagrant upp working.
- [x] djrun inside vm is working.
- [x] Make schema migrations working.
- [x] Create Skeleton page structure. Or attempt to make the fixtures going.
- [x] Fix ExperiencesRelationship.
- [x] Update the Locations model to Places.
- [x] Make Experience index page to be more like person index page.
- [x] Fix experience links on home page and individual host pages.
- [x] Find out how the main.scss is compiled to css inside doolay.
- [x] Refactor duplicate css code between template-place-page and template-experience-page.
- [x] Make Experience page like place page.
- [x] Fill data for experience pages.
- [x] Make images to display on experience pages.
- [x] Find out how to create django fixtures from existing postgres db.
- [x] Make host page able to add multiple interests. 
- [x] Add "language speak" field as snippet like HostInterest in hosts app.
- [x] Add interests like a tag to host page model like in Tutorials.
- [ ] Make iterests tags to label or display as "Interests" instead of "Tags" on HostPage Admin.
- [ ] Make iterests tags to display on Host Page. (Need to update the templates).
- [ ] Add duration field.
- [ ] Make Host and Experience to be one-to-many relationship. not many-to-many as it currently is.
- [ ] Do sanity testing (now the fixtures are loaded).
- [ ] Scout tour guides on the web and populate them as hosts.
- [ ] Create fixtures out of the test hosts.
- [ ] Create css tags display for multiple interests for live host page.

Fixtures
========
- [x] Continue testing prune_image_rendtions management command on mac mini.
- [ ] Find out how image renditions are created in the biginning after load_initial_data command is run.
- [ ] Re-do the fixtures.
- [ ] Remove duplicate image thumbnails and clean up images tables to use the one version.

E-mail
======
- [ ] Add e-mail button on Host page.
- [ ] Add e-mail template form for sending inquiry e-mails.
- [ ] Research for Email forwarding (like craigslist)
- [ ] Research using send-grid as e-mail backend.

Release
=======
- [ ] Test with gunicorn and nginx in Vagrant
- [ ] Deploy to GCE.
