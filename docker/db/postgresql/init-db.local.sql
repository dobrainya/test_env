CREATE ROLE dev_php WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION PASSWORD '123456';
CREATE DATABASE php_dev OWNER dev_php;
