# Wiki

## Indexing
Run the following to update the search indexes:
```
dj update_index
```
Run the command every time a model is updated.
Maybe create a cron to run everyday.


## Backing up
Run the following from the VM to get the pgdump
```
[doolay vagrant]$ pg_dump doolay > doolay.sql
```

## Launching GCE VM
```
vagrant up gce --provider=google
```
