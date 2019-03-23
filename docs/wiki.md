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
python manage.py dumpdata --natural-foreign --natural-primary  -e contenttypes -e auth.Permission --indent=4 --exclude sessions --exclude admin -e wagtailcore.groupcollectionpermission -e wagtailcore.grouppagepermission -e wagtailcore.pagerevision -e bookings.booking --format=json > doolay/fixture
s/test.json
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
