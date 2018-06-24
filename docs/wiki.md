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

### Using django dumpdata to fixtures
```
python manage.py dumpdata --natural-foreign --natural-primary --indent=4 --exclude sessions --exclude admin --format=json > doolay/fixtures/initial_data.json
```


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
