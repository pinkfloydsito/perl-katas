# Book API

## Overview

This API is a simple service for managing books. It's implemented using the Dancer2 web framework and relies on DBIC (DBIx::Class) for ORM functionalities. The API allows for basic CRUD operations on books.

## Features

- List all books: `GET /api/v1/book`
- Retrieve a book by ID: `GET /api/v1/book/:id`
- Add a new book: `POST /api/v1/book/`
- Delete a book by ID: `DELETE /api/v1/book/:id`

## Local Development Setup

### DBIx::Class Schema Generation

We use DBIx::Class for interacting with the database. To generate or update the DBIC schema, run the following command:

```bash
carton exec dbicdump  -o dump_directory=./lib Book::Schema 'dbi:Pg:dbname=books_db;host=localhost' demouser demouser_1234
```

Replace `/path/to/db.db` with the actual SQLite database file path.

### Running the Server

To run the application, we use Plack, and you can run it in "watch" mode for local development as follows:

```bash
carton exec -- plackup -R ./lib -r bin/app.psgi
```

This will start the Plack development server. The `-R ./lib` flag tells Plack to reload the application whenever files in the `./lib` directory change. The `-r` flag indicates to reload the application automatically upon file changes.