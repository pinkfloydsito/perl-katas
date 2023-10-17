DBNAME=books_db
DBUSER=postgres
DBPASS=postgres
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
	@$(PSQL) -U $(DBUSER) -h $(DBHOST) -p $(DBPORT) -c "ALTER DATABASE $(DBNAME) SET timezone TO 'UTC'" $(DBNAME)
	@$(ECHO) ✅

provision:
	@$(ECHO) -n "Provisioning ..."
	@$(PSQL) -U $(DBUSER) -h $(DBHOST) -p $(DBPORT) $(DBNAME) -f db/base.ddl

docker-build-db:
	docker build -t books_db .

docker-exec-db:
	docker run -p 5432:5432 books_db

setup-test-db:
	@$(CREATEDB) -U $(DBUSER) -h $(DBHOST) -p $(DBPORT) books_db_test -E UTF8
	@$(PSQL) -U $(DBUSER) -h $(DBHOST) -p $(DBPORT) -c "ALTER DATABASE books_db_test SET timezone TO 'UTC'" $(DBNAME)
	@$(ECHO) ✅

	@$(PSQL) -U $(DBUSER) -h $(DBHOST) -p $(DBPORT) books_db_test -f db/base.ddl


start:
	DBIC_TRACE=1 carton exec -- plackup -R ./lib -r bin/app.psgi

test:
	PLACK_ENV=test carton exec prove -lv t/