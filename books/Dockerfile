FROM postgres:latest

ENV POSTGRES_USER=demouser
ENV POSTGRES_PASSWORD=demouser_1234
ENV POSTGRES_DB=books_db

# Initialize the database
COPY ./db/init.sql /docker-entrypoint-initdb.d/

# Expose the PostgreSQL port
EXPOSE 5432

# Start PostgreSQL
CMD ["postgres"]