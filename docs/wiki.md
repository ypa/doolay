# Wiki

## Indexing
Run the following to update the search indexes:
```
dj update_index
```
Run the command every time a model is updated.
Maybe create a cron to run everyday.


## Backing up
### Using pg_dump
Run the following from the VM to get the pgdump
```
[doolay vagrant]$ pg_dump doolay > doolay.sql
```
### Using django dumpdata to fixtures
```
python manage.py dumpdata --indent=4 --exclude contenttypes --format=json > doolay/fixtures/db.json
```

## Launching GCE VM
```
vagrant up gce --provider=google
```
