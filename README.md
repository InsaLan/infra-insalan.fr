# insalan.fr infrastructure

This repository is here to hold all insalan.fr infrastructure.

## Installing and running insalan.fr

```sh
git clone git@github.com:InsaLan/infra-insalan.fr.git --recurse-submodules
make install
```

Before running the stack, fill in the django secret key in the .env file

```sh
make build-prod
make run-prod
```

Then to stop the containers:
```sh
make stop-prod
```

The website is available at the value of `WEBSITE_HOST` which should be `insalan.fr` or `localhost` depending on where it's running.
It's API backend is available at `api.WEBSITE_HOST`.

The "preprod" environment is available at `beta.WEBSITE_HOST` and it's own API at `api.beta.WEBSITE_HOST`.

## Running the dev environment

Put 1 in the .env file for the `DEV` variable
Run the following command : 
```sh
make run-dev
```
To simply run the dev environment

If you want to see the logs in real time, you should instead run :
```sh
make run-dev-attached
```
Then the dev frontend is available at dev.localhost
There is hotreload for the front (with vite), back (with django runserver), and nginx (thanks to a custom script)

To stop the dev environment :
```sh
make stop-dev
```

The dev frontend is available at `dev.WEBSITE_HOST` and it's API at `api.WEBSITE_HOST`.

## Cleanup

Docker can take a lot of disk space with all the images.
You have a few options to clean it up:

- `make clean-all` will remove all the containers and images
- `make clean-custom` will remove all the custom images (the ones we build and not the ones we pull from docker hub)
- `make sweep` will remove all the dangling images (deprecated images that are not used anymore)
- `make destroy-volumes` will remove all the dev and preprod volumes (the data stored by the containers)

## Additionnal commands
There are make targets to see the logs of each stack :
- `make logs-prod`
- `make logs-preprod`
- `make logs-dev`
