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
- [ ] Make Host and Experience to be one-to-many relationship. not many-to-many as it currently is.
- [ ] Add "language speak" field as snippet like HostInterest in hosts app.
- [ ] Add duration field as snippet in experiences app.
- [ ] Do sanity testing (now the fixtures are loaded).
- [ ] Find out how to create django fixtures from existing postgres db.
- [ ] Scout tour guides on the web and populate them as hosts.
- [ ] Create fixtures out of the test hosts.

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
