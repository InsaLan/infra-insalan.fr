# insalan.fr infrastructure

This repository is here to hold all insalan.fr infrastructure.

# Contributing

Please read carefully [the CONTRIBUTING.md file](./CONTRIBUTING.md) before any
contribution.

## Installing and running insalan.fr in local

```sh
git clone git@github.com:InsaLan/infra-insalan.fr.git --recurse-submodules
cp .env.dist .env
chmod 0600 .env
```

Edit your `.env` with your local settings then:

```sh
docker compose -f docker-compose-beta.yml up --build -d
```

You can also launch the beta synchronously to get the logs:

```sh
docker compose -f docker-compose-beta.yml up --build
```

Then to stop the containers:

```sh
docker compose -f docker-compose-beta.yml down
```

The website is available at the value of `WEBSITE_HOST` which should be
`insalan.fr` or `insalan.localhost` depending on where it's running.  It's API
backend is available at `api.WEBSITE_HOST`.

The "beta" environment is available at `beta.WEBSITE_HOST` and it's own API at
`api.beta.WEBSITE_HOST`. There is hotreload for the front (with
[vite](https://vite.dev/)), back (with django runserver), and nginx (thanks to a
custom script).

## Running the prod environment

Put 0 in the .env file for the `DEV` variable.
Run the following command:

```sh
docker compose -f docker-compose.yml build
docker compose -f docker-compose.yml up -d
```

To stop the prod environment:

```sh
docker compose -f docker-compose.yml down
```

The dev frontend is available at `WEBSITE_HOST` and it's API at
`api.WEBSITE_HOST`.

## Tests

It is possible to fully integrate the backend with VSCode by using the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers). This makes it possible to run and inspect tests from VSCode.

To do so, simply install the recommended extension and then run the "Dev Containers: Reopen in Container" VSCode command (Ctrl Shift P). You should then see the Tests tab on the sidebar and all the Django tests in there.

It is also possible to run the tests from command line:

```sh
docker exec infra-insalanfr-beta-backend-1 pytest
```

## Makefile

A [makefile](./Makefile) has been created to create shortcut for the command
presented above. For example, you can launch the beta just by typing:

```sh
make run-beta
```

And you can run the tests with

```sh
make test-back
```

## Cleanup

Docker can take a lot of disk space with all the images.
You have a few options to clean it up:

- `make clean-all` will remove all the containers and images
- `make clean-custom` will remove all the custom images (the ones we build and
  not the ones we pull from docker hub)
