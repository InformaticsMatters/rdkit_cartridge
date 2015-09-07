Dockerfile for building the RDkit PostgreSQL cartridge.
More info on the cartridge can be [found here](http://rdkit.org/docs/Cartridge.html)

To run use something like this:

`docker run -d -p 5432:5432 --name postgresdb <image id>`

To install cartridge into your specific database do something like this:

`docker exec -it <container_name> psql -h localhost -U docker -c 'CREATE EXTENSION rdkit' <postgres_db_name>`

or from within the container:

`psql -h localhost -U docker -c 'CREATE EXTENSION rdkit' <postgres_db_name>`
	

Note: this is quite a 'fat' disribution as it contains everything needed to build RDKit as well as postgreSQL.
As such its suitable as a general purpose hacking box, but for deployment purposes it would be possible to 
create a more lightweight version. I may do this in the future. Let me know if there is demand for this.