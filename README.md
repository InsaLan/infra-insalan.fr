# insalan.fr infrastructure

This repository is here to hold all insalan.fr infrastructure.

## Installing and running insalan.fr

```sh
git clone git@github.com:InsaLan/infra-insalan.fr.git --recurse-submodules
cp .env.dist .env # edit your .env with your local settings then:
chmod 0600 .env
docker compose up -d
```
