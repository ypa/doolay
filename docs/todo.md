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
- [x] Make iterests tags to label or display as "Interests" instead of "Tags" on HostPage Admin.
- [x] Add duration field.
- [x] Add duration field on the experience page template.
- [x] Style duration field on the experience page - make the layout right.
- [x] Fix duration hour only.
- [x] Update place images.
- [x] Make Host and Experience to be one-to-many relationship. not many-to-many as it currently is.
   - [x] Make a backup of the postgres db on laptop.
   - [x] Host to Experience == One to many.
   - [x] Experience to Place == Many to one.
   - [x] Fix styles on place index page with experiences. Removed experience thumbnails on place index page.
- [x] Add experience list on each place page.
- [x] Fix experience links on Host index page.
- [x] Make experience list display work on Place page. Perhaps a grid with brief summary, duration and host.
- [x] Fix Field Panel for host on Experience Page Admin.
- [x] Fix search for host PageChooser field on Experience Page Admin.
- [ ] Do sanity testing (now the fixtures are loaded).
- [ ] Scout tour guides on the web and populate them as hosts.
- [ ] Test out css with miligram


Fixtures
========
- [x] Create fixtures out of the test hosts.
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


Blog
====
- [ ] Blog List page (as an archive of previous blog posts)
- [ ] Blog Page
- [ ] Have home page display some of the featured/new blog pages. 
