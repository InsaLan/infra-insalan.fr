\set user_name `echo ${INSALAN_USERNAME}`
\set user_pass `echo ${INSALAN_PASSWORD}`
\set db_name `echo ${INSALAN_DATABASE}`

CREATE USER :user_name WITH PASSWORD :'user_pass';
CREATE DATABASE :db_name;
GRANT ALL ON DATABASE :db_name TO :user_name;
\c :db_name
GRANT USAGE, CREATE ON SCHEMA public TO :user_name;

