# SQL / SQlite  README
###### Last update: 11/3/23 dbe --- adding sql sandbox platforms+tools
</br>  

![image](https://user-images.githubusercontent.com/52699611/158074344-d10d01a2-34b8-4dff-a7e3-d26b7bd118b1.png)

--- 
### [SQLite Sample Database & Tutorial](https://www.sqlitetutorial.net/sqlite-sample-database/)

Introduction to chinook [SQLite](https://www.sqlite.org/index.html) sample database. We provide you with the SQLite sample database named chinook. The chinook sample database is a good database for practicing with SQL, especially SQLite.

![image](https://user-images.githubusercontent.com/52699611/158073902-ac142af3-ca85-4fe8-81f5-cef62ca1094a.png)

### The Chinook Sample Database Tables
There are **11 tables** in the chinook sample database.

+ **employees** table stores employees data such as employee id, last name, first name, etc. It also has a field named ReportsTo to specify who reports to whom.  
+ **customers** table stores customers data.  
+ **invoices** & **invoice_items** tables: these two tables store invoice data. The invoices table stores invoice header data and the invoice_items table stores the invoice line items data.  
+ **artists** table stores artists data. It is a simple table that contains only the artist id and name.  
+ **albums** table stores data about a list of tracks. Each album belongs to one artist. However, one artist may have multiple albums.  
+ **media_types** table stores media types such as MPEG audio and AAC audio files.  
+ **genres** table stores music types such as rock, jazz, metal, etc.  
+ **tracks** table stores the data of songs. Each track belongs to one album.  
+ **playlists** & **playlist_track** tables: playlists table store data about playlists. Each playlist contains a list of tracks. Each track may belong to multiple playlists. The relationship between the playlists table and tracks table is many-to-many. The playlist_track table is used to reflect this relationship.  

### Download SQLite Sample Database
You can download the [SQLite sample database](https://github.com/sawubona-gmbh/BINA-FS22-WORK/blob/main/LB03-DataModelingDataStorage/SQL/sqlite-sample-database-chinook.db) from this repository and explore the *xxx.db* file with an Online SQLite Browser (eg. [SQLite Viewer](https://inloop.github.io/sqlite-viewer/)), a local SQlite Browser installation (e.g. [DB Browser for SQlite ](https://sqlitebrowser.org/))  or a [Python script](https://towardsdatascience.com/python-sqlite-tutorial-the-ultimate-guide-fdcb8d7a4f30)

In case you want to have the database diagram for reference, you can download both black&white and color versions in PDF format.

--- 
### SQL Sandbox Environment/Platform    

![image](https://user-images.githubusercontent.com/52699611/224561575-333b4e83-e431-4a61-9485-3ca0b6f49a6d.png)

+ [SQL Tutorial](https://www.w3schools.com/sql/default.asp) at [W3Schools](https://www.w3schools.com/) - Learn to Code, with the world's largest web developer site.  
W3Schools is a website for learning a range of programming concepts including SQL. They offer an SQL practice feature using exercises, where you fill in the blanks to write queries. It’s not as fully-featured as some other examples here, as it doesn’t have an SQL editor, but it can help you improve your SQL by completing queries.  
+ [SQLFiddle](http://sqlfiddle.com/) - A tool for easy online testing and sharing of database problems and their solutions.  
SQL Fiddle is a popular site for quickly generating sample databases and writing SQL code on them. It can also be used for SQL practice. It’s a common way for users on StackOverflow to generate sample data because the data sets are saved on SQLFiddle and you can generate a link to that data set.  
+ [SQLBolt](https://sqlbolt.com/) - Learn SQL with simple, interactive exercises.  
SQL Bolt is a site that teaches SQL as well as including several exercises on each concept. At the end of each page is a sample data set, and several questions you can answer using SQL. While it doesn’t have the same flexibility as an online editor like SQLFiddle, it does explain the concepts and includes SQL practice exercises which are helpful. It’s a popular resource for people to practice.  
+ [Oracle Live SQL](https://livesql.oracle.com) - Learn and Share SQL. Running on Oracle Database 19c  
Oracle Live SQL is a tool created by Oracle that lets you write and run SQL code against an online Oracle database. You can write code to create and populate tables and select data from them. It’s a handy way to practice Oracle-specific SQL online. It also includes some helpful scripts as resources in the code library section and several tutorials on how to improve your SQL. See also [Oracle Live SQL - The Complete Guide](https://www.databasestar.com/oracle-live-sql/) from Databasestar  

+ [dbdiagram.io](https://dbdiagram.io/home?utm_source=dbdiagram) - Draw Entity-Relationship Diagrams, Painlessly  
A free, simple tool to draw ER diagrams by just writing code. Designed for developers and data analysts.  

---  
### SQLite Online Browser


+ [SQLite Browser](https://extendsclass.com/sqlite-browser.html) -  This SQLite browser allows you to create, open, query, update, export SQL to CSV, save and share a SQLite database.This SQLite viewer online runs directly in your browser.  
+ [SQLIte Viewer App](https://sqliteviewer.app/#/) - SQLite Viewer Web is a free, web-based SQLite Explorer, inspired by DB Browser for SQLite and Airtable.  
+ [DB Browser for SQLite](https://sqlitebrowser.org/) - DB Browser for SQLite (DB4S) is a high quality, visual, open source tool to create, design, and edit database files compatible with SQLite. DB4S is for users and developers who want to create, search, and edit databases. DB4S uses a familiar spreadsheet-like interface, and complicated SQL commands do not have to be learned. 
