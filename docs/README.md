# Documentation deployment

The `deploy_docs.sh` script is meant to be called by a
[CRON](https://manpages.ubuntu.com/manpages/xenial/fr/man8/cron.8.html) task
to deploy the already built static documentation pages on the InsaLan VPS.

The `mappings.txt` is meant to map a fetch URL with a path on the VPS to the
deployed directories.
