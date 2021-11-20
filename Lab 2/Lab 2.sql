drop schema if exists Library;
create schema LIBRARY ;
use LIBRARY ; 

# (Q1)

create table PUBLISHER (
    Phone int,
    Name varchar(255) NOT NULL,
    Address varchar(255),
	primary key (Name)
);

create table Book (
    Book_id int NOT NULL,
    Title varchar(255),
    Publisher_name varchar(255),
	primary key (Book_id),
	foreign key (Publisher_name) REFERENCES PUBLISHER(Name)
);

create table BOOK_AUTHORS (
    Book_id int,
    Author_name varchar(255) NOT NULL,
	foreign key (Book_id) REFERENCES Book(Book_id),
	primary key (Author_name,Book_id)
);

create table LIBRARY_BRANCH (    
    Branch_id int not null,
	Branch_name varchar(255),
    Address varchar(255),
	primary key (Branch_id)
);

create table BORROWER (
    Card_no int not null,
	borrowerName varchar(255),
	Address varchar(255),
	Phone int,
	primary key (Card_no)
);

create table BOOK_LOANS (
    Book_id int,
    Branch_id int,
    Card_no int,
	Date_out date,
    Due_date date,
	foreign key (Book_id) REFERENCES Book(Book_id),
	foreign key (Branch_id) REFERENCES LIBRARY_BRANCH(Branch_id),
	foreign key (Card_no) REFERENCES BORROWER(Card_no),
	primary key (Card_no,Branch_id,Book_id)
);

create table BOOK_COPIES (
    Book_id int ,
    Branch_id int ,
    No_of_copies int ,
	foreign key (Book_id) REFERENCES Book(Book_id),
	foreign key (Branch_id) REFERENCES LIBRARY_BRANCH(Branch_id),
	primary key (Branch_id,Book_id)
);

# (Q2)

INSERT INTO publisher VALUES (12895020, 'omar', 'Alex, Shatby');
SELECT * FROM publisher ; 

UPDATE publisher SET Address = 'Cairo' WHERE name = 'omar';
SELECT * FROM publisher ; 

DELETE FROM publisher WHERE  name = 'omar';
SELECT * FROM publisher ; 

# (Q3)

INSERT INTO publisher VALUES (5425670, 'omar', 'Alex, Shatby');
SELECT * FROM publisher ; 

INSERT INTO Book VALUES (1, 'Book', 'omar');
SELECT * FROM book ; 

UPDATE publisher SET Address = 'Cairo' WHERE name = 'omar';
SELECT * FROM publisher ; 

#UPDATE publisher SET name = 'ahmed' WHERE name = 'omar';
SELECT * FROM publisher ; 
# Update: We can not change a tuple value if the attribute of this tuble is referenced as a foriegn key in another table.

#DELETE FROM publisher WHERE  name = 'omar';
SELECT * FROM publisher ; 
# Delete:  We can not delete a row if the attribute of this tuble is referenced as a foriegn key in another table.

# Clear all data in the tables to get them ready to enter new data to solve question 4 accurately

DELETE FROM Book WHERE  Publisher_name = 'omar';
SELECT * FROM Book ; 

DELETE FROM publisher WHERE  name = 'omar';
SELECT * FROM publisher ; 

# (Q4)

# Insert complete specific data to the Library schema to solve the question 4 accurately

INSERT INTO PUBLISHER VALUES (01113077857, 'ahmed', 'alexandria');
INSERT INTO PUBLISHER VALUES (01113077888, 'omar', 'cairo');
INSERT INTO PUBLISHER VALUES (01003077888, 'moaz', 'giza');
INSERT INTO BOOK VALUES (1, 'The Lost Tribe', 'ahmed');
INSERT INTO BOOK VALUES (2, 'kalila w demna', 'omar');
INSERT INTO BOOK VALUES (3, 'the art of giving shit' ,'moaz');
INSERT INTO BOOK_AUTHORS VALUES (1, 'Stephen King');
INSERT INTO BOOK_AUTHORS VALUES (2, 'Ahmed Mousa');
INSERT INTO BOOK_AUTHORS VALUES (3, 'Stephen King');
INSERT INTO LIBRARY_BRANCH VALUES (100, 'Central', 'cairo');
INSERT INTO LIBRARY_BRANCH VALUES (200, 'Sharpstown', 'paris');
INSERT INTO LIBRARY_BRANCH VALUES (300, 'Gleem', 'alexandria');
INSERT INTO BORROWER VALUES (1000, 'Messi', 'france', 01000000000);
INSERT INTO BORROWER VALUES (2000, 'Inesta', 'japan', 01111111111);
INSERT INTO BORROWER VALUES (3000, 'Xavi', 'spain', 01222222222);
INSERT INTO BORROWER VALUES (4000, 'Alves', 'spain', 01322222222);
INSERT INTO BORROWER VALUES (5000, 'Neymar', 'spain', 01422222222);
INSERT INTO BORROWER VALUES (6000, 'Pique', 'spain', 01522222222);
INSERT INTO BOOK_LOANS VALUES (1, 100, 1000, '2020-10-10', '2021-12-10');
INSERT INTO BOOK_LOANS VALUES (2, 200, 2000, '2020-10-10', '2021-12-10');
INSERT INTO BOOK_LOANS VALUES (3, 300, 3000, '2020-10-10', '2021-12-10');
INSERT INTO BOOK_COPIES VALUES (1, 100, 11);
INSERT INTO BOOK_COPIES VALUES (1, 200, 22);
INSERT INTO BOOK_COPIES VALUES (2, 200, 33);
INSERT INTO BOOK_COPIES VALUES (3, 300, 44);

# (Q4)(a)

select No_of_copies from BOOK 
join BOOK_COPIES ON BOOK.Book_id = BOOK_COPIES.Book_id
join LIBRARY_BRANCH ON LIBRARY_BRANCH.Branch_id = BOOK_COPIES.Branch_id
where Title = 'The Lost Tribe' AND Branch_name ='Sharpstown' ;

# (Q4)(c)

SELECT borrowerName FROM Borrower as B
	LEFT OUTER JOIN Book_Loans as BL
	 on B.Card_NO LIKE BL.Card_NO
	 WHERE BL.Card_NO is NULL;

# (Q4)(e)

select Branch_name, count(Book_id) as total_books
from LIBRARY_BRANCH
join BOOK_LOANS on  LIBRARY_BRANCH.Branch_id = BOOK_LOANS.Branch_id
group by LIBRARY_BRANCH.Branch_id ;

# (Q4)(g)

(Select title , sum(no_of_copies) as totalNumberOfCopies 
from ((library_branch natural join book_copies) natural join book_authors) natural join  book
where author_name = 'Stephen King' and branch_name = 'Central'
group by book_id)
UNION 
(Select title , sum(no_of_copies) as totalNumberOfCopies 
from (select name as publisher_name, address as publisher_address, phone from publisher) as publisher
natural join (book  natural join (library_branch natural join book_copies))
where publisher_name = 'Stephen King' and branch_name = 'Central'
group by book_id);
