# Wiki

## Indexing
Run the following to update the search indexes:
```
dj update_index
```
Run the command every time a model is updated.
Maybe create a cron to run everyday.


## Running Code Formatter using yapf
```
$ pwd # root of the project
/Users/ypa/work/doolay/doolay
$ yapf -r ./doolay/ -e "*migrations*" -vv | grep -i reformatting # Dry run: find out what files to be formated
$ yapf -r ./doolay/ -e "*migrations*" -vv -i # format the files in place
```


## Backing up
### Using pg_dump
Run the following from the VM to get the pgdump
```
[doolay vagrant]$ pg_dump doolay > doolay.sql
```

### Dropping database (careful!)
And then recreating it from the backup file.
```
[doolay vagrant]$ dropdb doolay
[doolay vagrant]$ createdb doolay
[doolay vagrant]$ psql doolay < doolay.sql
```

### Using django dumpdata to fixtures
```
python manage.py dumpdata --natural-foreign --natural-primary --indent=4 --exclude sessions --exclude admin --format=json > doolay/fixtures/initial_data.json
```

For unittest base test data (excluding unnessary tables)
```
python manage.py dumpdata --natural-foreign --natural-primary  -e contenttypes -e auth.Permission --indent=4 --exclude sessions --exclude admin -e wagtailcore.groupcollectionpermission -e wagtailcore.grouppagepermission -e wagtailcore.pagerevision -e bookings.booking --format=json > doolay/fixtures/test.json
```
Then open the file and manually set the `live_revision` fields to `null`.


## Launching GCE VM
```
vagrant up gce --provider=google # This could take a long long time (to establish connection with google). It might be better to do it on Mac Mini.
```

## Demo website
http://demo.doolay.com

### Admin
Admin Url: http://demo.doolay.com/admin

- Login: testuser
- Pwd:T...@1

- Login2: admin
- Pwd: D...@1

### Logs

- App log:
```
[doolay vagrant]$ less ~/sites/staging.doolay.com/error.log
```
- Gunicorn startup log:
```
[doolay vagrant]$ less ~/sites/staging.doolay.com/gunicorn-error.log
```

### Setting up bare minimum site with Home page as Root

This minimum site setup could be used for extracting fixtures for the unittests. See the above on how to run `manage.py dumpdata` whithout unnecessary tables.

0. Creating DB from scratch
```
createdb doolay
./manage.py migrate
./manage.py createsuperuser
```
1. Start the server and login to `/admin` with user created in the previous step.
2. Click on `Pages` on the left nav -> Click on the little home icon on top next to the Pages. It should take you to the **Root** admin page. Welcome to your new Wagtail site! is listed as only one child page on that **Root** admin.
3. Add a child page under **Root** by clicking on the button on top of the page.
4. It should take to "New Home page", fill in info: Title -> `Home`, Who You Are -> `Doolay`, Organization Strap Line -> `The Road goes...`. Before you save/publish click on `Promote` tab and update `Slug:` field as `homepage`. Click Publish.
   Back on **Root**, you should see Home page listed above the "Welcome.." page now.
5. Delete the "Welcome to your new Wagtail site!" page, confirm the deletion.
6. Click on "Configure a site now." link on **Root**, Click `+ ADD A SITE` button on the top right.
7. Fill Hostname -> `localhost`, Port -> `80`, Root page -> Choose A Root page -> `Home`, Check `Is Default site`. Save. At this point you might want to visit the site root URL `/`, for example `http://localhost:8000/` and see the live Home page.
8. Back on admin add `Languages` via `Snippets` on the left nav.
9. Add Index pages. From Left Nav click `Pages` -> `Home`. Clicking on `Child Child Page` and add index pages with these titles: `Blog`, `Places`, `Hosts`, `Places`. Make sure you publish them.
10. Add each of the child pages for the index pages created in this order: a place page -> a host page ->  an experience page -> a blog page. Publish them.

Visit the URLs: `/experiences/`, `/hosts/`, `/places/` and other individual pages. Those pages should be live now.


### Running Unittests

```
$ vagrant up dev
$ vagrant ssh dev
[doolay vagrant]$ pip install -r requirements/dev.txt  # installing model_mommy etc
[doolay vagrant]$ ./manage.py test  # running the whole suite
# To run individual test
[doolay vagrant]$ ./manage.py test doolay.bookings.tests.BookingSlotRequestCreateViewTest.test_slot_request_raises_validation_error_if_not_available
```

### Gotchas

#### Unittest caching site root paths

Sometimes after running unittests and then when you start up the dev server with `djrun` you might run into the broken pages with at:
```
...
'NoneType' object has no attribute 'startswith'
...
Exception Location:	/vagrant/doolay/home/templatetags/navigation_tags.py in top_menu, line 65
```

That is because site root paths are getting cached in Redis. Some of my debugging outputs from `pdb`:
```
<function RedisCache.get at 0x7ff0f17ee840>
(Pdb) p method(self, 'wagtail_site_root_paths')
[(1, '/home/', 'http://localhost'), (2, '/home/', 'http://localhost:8081')]
```

You could resolve it by flushing the Redis cache:
```
[doolay vagrant]$ redis-cli flushall
```
