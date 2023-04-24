# insalan.fr infrastructure

This repository is here to hold all insalan.fr infrastructure.

## Installing and running insalan.fr

```sh
git clone git@github.com:InsaLan/infra-insalan.fr.git --recurse-submodules
cp .env.dist .env # edit your .env with your local settings then:
chmod 0600 .env
docker compose up -d
```

To run the dev environment :
Put 1 in the .env file for the `DEV` variable
Run the following command : 
```sh
docker compose -f docker-compose-dev.yml up --build
```
Then the dev frontend is available at dev.localhost
There is hotreload for the front (with vite), back (with django runserver), and nginx (thanks to a custom script)
