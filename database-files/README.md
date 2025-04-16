# `database-files` Folder

TODO: Put some notes here about how this works.  include how to re-bootstrap the db. 

#  Bootstrap SQL Data — *Ideate Project*

This repository includes a SQL file used to bootstrap the database for the **Ideate** project. It contains sample data and possibly schema definitions, created to simulate a real working environment for development and testing purposes.

## File Included

- **`Ideate.sql`**  
  A SQL script containing `INSERT` statements to prepopulate the database with mock data. The data was generated using Mockaroo. 

## How to Use

### Prerequisites

- A running instance of your SQL database (MySQL)
### Steps

1. Open your terminal or database client.
2. Connect to your development database.
3. Run the following command (for MySQL):
   ```bash
   mysql -u your_username -p your_database_name < Ideate.sql
   ```

4. Verify that the tables are populated correctly by running a few `SELECT` queries:
   ```sql
   SELECT * FROM Project LIMIT 5;
   SELECT * FROM Member LIMIT 5;
   ```

*(Adjust table names based on your actual schema inside the SQL file.)*



