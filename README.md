# Docker wordpress-duplicator container

Out-of-the-box docker image for bootstrapping a Wordpress migration using the
[Duplicator](https://wordpress.org/plugins/duplicator/) plugin.

It is designed to be linked to a MySQL and optional data container.

The data container can be used to store the wp-content folder as well as create
the database without exposing admin credentials to this container.

**TODO:** update the readme below to document new environment variables.

Quick summary:

* data container, aliased as DATA
  * exposes DATA_DB_NAME, _USER, and _PASS
* mysql container, aliased DB
  * exposes DB_PORT_3306_TCP_ADDR and DB_PORT_3306_TCP_PORT
* Duplicator files go in /duplicator
 * best to use a host mounted volume for that

See Ramblurr/docker-wp-data and Ramblurr/tutum-docker-wordpress-nosql


