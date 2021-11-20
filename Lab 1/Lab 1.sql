drop schema if exists phonebook;
Create Schema phonebook;
Use phonebook;

Create Table Person (
Id Varchar (5) Primary Key Not Null,
Pname Varchar(40),
DOB Date,
Paddress Varchar (100));

Create Table Tel (
Pid Varchar(5),
Tserial Varchar (3),
Telno Varchar (15),
Constraint pk Primary Key (Pid, Tserial),
Constraint fk Foreign Key (Pid) references Person (Id));

# You can insert few records by using the following statements

Insert into Person values (1,'john','1970-01-03','5 shore st.' );
Insert into Tel values (1,1,'03-2245655' );
Insert into Tel values (1,2,'012-6453242' );
Insert into Person values (2,'mark','1967-07-08','5 shore st.' ); 
Insert into Tel values (2,1,'03-8644353' );

# Finally, you can enter a simple query to test the entered data as following

Select Id, Pname, DOB, paddress, Tserial, Telno from Tel , Person