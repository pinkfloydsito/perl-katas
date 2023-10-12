DBNAME=books_db
DBUSER=demouser
DBPASS=demouser_1234
DBHOST=localhost
DBPORT=5432
PSQL=PGOPTIONS='--client-min-messages=warning' psql -X -q --single-transaction
CREATEDB=createdb
DROPDB=dropdb
ECHO=$(shell which echo || /bin/echo)

all: createdb \
	 provision \
	 @echo Finished 🏁

createdb:
	@$(CREATEDB) -U $(DBUSER) -h $(DBHOST) -p $(DBPORT) $(DBNAME) -E UTF8
	@$(PSQL) -U $(DBUSER) -h $(DBHOST) -p $(DBPORT) -c "ALTER DATABASE $(DBNAME) SET timezone TO 'UTC'" $(DBNAME) -f extensions.ddl
	@$(ECHO) ✅

provision: error_handling
	@$(ECHO) -n "Provisioning ..."
	@$(PSQL) -U $(DBUSER) -h $(DBHOST) -p $(DBPORT) $(DBNAME) -f base.ddl

docker-build-db:
	docker build -t books_db .

docker-exec-db:
	docker run -p 5432:5432 books_db