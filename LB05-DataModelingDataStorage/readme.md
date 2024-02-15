# LB05 - Data Modeling and Data Storage README
###### Last update: 12/2/24 dbe - modified LB numbering
</br>

![LB05](https://github.com/sawubona-gmbh/BINA-FS22-WORK/blob/main/zImages/MSc-WI_BINA_LB3_Data%20Modeling.png)

## A) Relational Data Model

Im Vorwort zu seinem Standardwerk *The RELATIONAL MODEL for DATABASE MANAGEMENT* schreibt [Edgar F. Codd](https://de.wikipedia.org/wiki/Edgar_F._Codd) "In developing the relational model, I have tried to follow Einstein's advice, *Make it as simple as possible, but no simpler." 

The relational model (RM) for database management is an approach to managing data using a **structure and language** consistent with **first-order predicate logic**, first described in 1969 by English computer scientist Edgar F. Codd, where all data is represented in terms of **tuples**, grouped into **relations**. 
A database organized in terms of the relational model is a relational database (RDB). Corresponding an system to handle a relational database is called a relational database management system (RDBMS). 
The purpose of the relational model is to provide a declarative method for specifying **data and queries**: users directly state what information the database contains and what information they want from it, and let the database management system (DBMS) take care of describing data structures for storing the data and retrieval procedures for answering queries. Most relational database management system use the **SQL** data definition and query language.
![image](https://user-images.githubusercontent.com/52699611/156620407-374d817b-97d9-4b91-8322-fe6c87deb3f1.png)


* [The RELATIONAL MODEL for DATABASE MANAGEMENT (Version 2)](https://github.com/sawubona-gmbh/BINA-FS22-WORK/blob/main/LB03-DataModelingDataStorage/BOOK_Codd_The%20Relational%20Model%20Version%202_EXTRACT.pdf)
*A PDF Version of Cood's book*  
* [Entity Relationship Diagram Video Tutorial](https://www.youtube.com/watch?v=QpdhBUYk7Kk)
*Als Online Modellierung- und Visualisierungswerkzeug zur Entwicklung von ERDs kann bspw. [Lucidchart](https://www.lucidchart.com) eingesetzt werden. Unter dem folgenden [Link](https://lucid.app/lucidchart/invitations/accept/inv_0ca57e41-03ce-4b3f-9b73-2f9f29987555) kann ein ERD Beispiel zu den Covid Daten der Johns Hopkins University (Stand März 2021) eingesehen werden*     
* [Online SQL Tutorial](https://www.w3schools.com/sql/default.asp)
*Direkter Umgang mit einer (cloud) RDBMS - MySQL - kann unter [DB Fiddle](https://www.db-fiddle.com/) einem SQL Database Playground geübt werden*       
</br>

## B) Relational Database Management System   

The RDBMS is the most popular database system among organizations across the world. It provides a dependable method of storing and retrieving large amounts of data while offering a combination of system performance and ease of implementation. RDBMS is the basis for all modern database systems such as MySQL, Microsoft SQL Server, Oracle, and Microsoft Access.  
![image](https://user-images.githubusercontent.com/52699611/156620200-83b0c50d-34a4-4d0f-b193-f2fd2c6a38cb.png)

* [SQLite](https://sqlite.org/index.html) is a C-language library that implements a small, fast, self-contained, high-reliability, full-featured, SQL database engine. SQLite is the most used database engine in the world. SQLite is built into all mobile phones and most computers and comes bundled inside countless other applications that people use every day  
* An Online Playgorund for different RDBMS implementations is available on [SQlite Online](https://sqliteonline.com/)  

</br>  

## C) Entity-Relationship Diagram (ERD)   

the *Entity Relationship Diagram*, also known as ERD, ER Diagram or ER model, is a type of structural diagram for use in database design. An ERD contains different symbols and connectors that visualize two important information: The major **entities** within the system scope, and the inter-**relationships** among these entities.

See also Daniel Soper's Youtube Tutorial on [Data Modelling and Entity-Relationship Diagrams](https://youtu.be/IfaqkiHpIjo)  
![image](https://user-images.githubusercontent.com/52699611/157514116-340fde84-d54c-44c5-9bd0-ed81e4bf751d.png)

* [CHEN ERD Notation](https://www.vertabelo.com/blog/chen-erd-notation/) 
* [CROW's FOOT ERD Notation](https://www.vertabelo.com/blog/crow-s-foot-notation/)   




