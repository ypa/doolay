- Created doolay repo
- Installed Wagtial CMS from cookiecutter
- Updated Skills body to Streamfield
- Updated People to Hosts
- Updated Statuses to Interests
- Transformed Skills to Experiences
- Fix some relationships between experiences and hosts.
- Get vagrant up to working.
- Got schemamigrations working.
- Updated fixtures.
- Fix bugs with navigation and typo in navigation menu.
- Tested repo with vagrant up on Mac mini.
- Renamed locations to places app.
- Made experience index page more like place index page.
- Made experience page to look like place page.
- Fixed experience links on host pages.
- Combined templage-experience/place-page scss body class.
- Added content for experience pages.
- Made images to display on experience pages (just a display setting on admin).
- Updated fixtures data and images.
- Tested fixtures on Mac.
- Worked on fixing fixtures.
- Coninued testing fixtures.
- Turn Interests into languages speak (model) for the host page.
- Started working on interests as a taggit model. (WIP).
- Added interests as taggit item.
- Made iterests tags to label or display as "Interests" instead of "Tags" on HostPage Admin.
- Removed interests from hosts app - backed out/did 'git revert' on every commit related to interests field.
- Added DurationField to experiences model and migrations.
- Added Duration field on experience_page template.
- Downloaded images for places.
- First pass at making host experience relationships into one to many.
- Updated field panels for host experience model relations.
- Fixed experience page template for displaying the "one" host. 
- Made place to experience one to many relationship.
- Tried makeing host filed a parental key on expeirence page and have 'providing experiences' as inline field on host page. It doesn't look right, so reverted back.
- Fixed host thumbnails on experience index page.
- Researched on wagtail ModelAdmin and django ModelAdmin.raw_id_field for getting search work on admin experience page for host field panel.
- Worked on picnic branch and fixed the header, main nav and breadcrumbs
- Stripped imports on main.scss leaving only utils
- Created spectre branch and downloaded and installed spectre css files
- Spectre - Styled the header nav bar.
- Spectre - Updated breadcrumbs and body font weight and margin. (looking good)
- Style test footer; Experimented with grid layouts on places page. Next step try Spectre Cards with palces page. Btw, At Yosemite!!!
- Fix place index page with spectre layout grids.
- Update place index page with spectre cards.
- Place index page work continued, included body inside cards and made images clickable links.
- Spectrefy experience index page, work in progress.
- Continue spectrefy experience index page, fix the hosts's avatars.
- Spectrefy host index page.
- Spectrefy experience page, work in progress.
- Spectrefy host page.
- Researched for video embed.
- Make youtube video embed look right.
- Style/Copied style (from http://duck:8000/...) for lead image page for individual experience page and place page.
- Make lead_image wide out.
- Fix top nav in base.html. work in progress.
- Worked on top nav and footer spacing.
- Fixed/spectrefy experiences grid to individual place page.
- Fixed permalinks.
- Make "Blog" to appear on top menu. From admin > Blog > Promote Tab > check checkbox "Show in menus".
- Read up on vagrant repackaging from existing base vagrant box.
- Released a new vagrant box vzmm/doolay with Nginx installed based on torchbox's wagtail vagrant box.    
- Created a branch gce with Vagrant configs for Google Compute Engine.
- Created a debian image viag Vagrant gce.
- Provisioned vagrant gce box.
- Provisioned/installed gce box, doolay-demo and successful ran djrun as ypa.
- Create a base gce box image named doolay-jessie as vagrant user.
- Fixed (deleted old and created new) doolay-jessie image with ssh user vagrant with added authorized_keys.
- Worked on configuring nginx and gunicorn on virtualbox. WIP.
- Configured nginx successful, gunicorn not responding getting 502 BAD Gateway.
- Created a seperated vagrant VM for GCE so that you can now launch `vagrant up gce --provider=google` and normal `vagrant up` will launch Virtualbox.
- First attempt at storing 'collectstatic'ed files in amazon s3.    
- Added provisioning for copying media fixtures to demo branch.
- Added nginx config for serving media dir.
- Added cleanup_wagtailimage_renditions command to demo branch.
- Tested demo branch on laptop.
- Provision demo branch on gce.
- Fixed demo gce instance (needed to install nginx and add ALLOWED_HOSTS in prod settings).
- Created A record on Gandi and point DNS to the gce insance, staging.doolay.com is live. Yay!
- Created a new gce image "doolay-jessie2" with nginx already installed updated demo branch to use it.
- Tested re-creation of the gce doolay-demo VM instance.
- Tested and pointed demo site to the new VM created from demo branch, deleted the old VM.
- Opened up sendgrid account. username:doolay
- Added e-mail field to Host page.
- Researched django e-mail apps and Wagtail forms with AbstractEmailForm.
- Started working on email message form.
- Created models and migrations for messaging. And ran migrations.
- Worked on contact e-mail page. Cannot use it. It's just for the contact page.
- Worked on contact e-mail form for host page.
- More work on e-mail form on host page.
- More work on e-mail, working now on rc3. Next step is to write a managemanet command to create form fields for all the host pages.
- More digging into wgatail AbstractEmailForm. Ditched the idea. Will use just regular Django form for e-mailing. 
- Added contacts app; from https://hellowebbooks.com/news/tutorial-setting-up-a-contact-form-with-django/
