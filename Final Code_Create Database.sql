CREATE DATABASE Final_Assignment1_Qatar2022FootballWorldCupDB;
USE Final_Assignment1_Qatar2022FootballWorldCupDB;

-- Create the Customer table
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_name Varchar(250),
    Email_address Varchar(250),
    Phone_number Varchar(20)
    );
    
    -- Create the Ticket_type table
    CREATE TABLE Ticket_type (
    Ticket_type_ID INT PRIMARY KEY,
    Ticket_type_description VARCHAR(200),
    Ticket_type_Price INT,
    Ticket_type_category VARCHAR (50)
);

-- Create the Ticket_transaction table
CREATE TABLE Ticket_transaction (
    Customer_ID INT,
    Ticket_type_ID INT,
    Ticket_type_bought INT,
    Payment VARCHAR (20),
    PRIMARY KEY (Customer_ID, Ticket_type_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Ticket_type_ID) REFERENCES Ticket_type(Ticket_type_ID)
);


-- Create the Game_ticket table
CREATE TABLE Game_ticket (
    Game_ticket_ID INT PRIMARY KEY,
	Ticket_type_ID INT,
    Game_ticket_date date,
    Team Varchar(50),
    Stadium_name Varchar(250),
    Seat_location VArchar (20),
    FOREIGN KEY (Ticket_type_ID) REFERENCES Ticket_type(Ticket_type_ID)
);
    
    -- Create the Game_match table
CREATE TABLE Game_match (
    Game_ID INT PRIMARY KEY,
	Game_ticket_ID INT,
    Category Varchar(50),
    Team Varchar(50),
    Stadium_name Varchar(250),
    Capacity INT,
    FOREIGN KEY (Game_ticket_ID) REFERENCES Game_ticket(Game_ticket_ID)
);

-- Create the Trains table
CREATE TABLE Train (
    Train_ID INT PRIMARY KEY,
    Game_ID INT,
    Capacity INT,
    Minute_to_arrive_to_Stadium INT,
    Train_speed Varchar (50),
    FOREIGN KEY (Game_ID) REFERENCES Game_match(Game_ID)
);

-- Create the Game Day Train table
CREATE TABLE Game_day_train (
    Game_ID INT,
    Train_ID INT,
    Game_day_train_ticket_ID INT,
    PRIMARY KEY (Game_ID, Train_ID),
    FOREIGN KEY (Game_ID) REFERENCES Game_match(Game_ID),
    FOREIGN KEY (Train_ID) REFERENCES Train(Train_ID)
);

-- Create Room_type Table
CREATE TABLE Room_type (
    Room_type_ID INT PRIMARY KEY,
    Room_type_name VARCHAR(100),
    Room_type_rate INT,
    Customer_ID INT,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

-- Create Room_transaction Table
CREATE TABLE Room_transaction (
    Transaction_ID INT PRIMARY KEY,
    Customer_ID INT,
    Room_type_ID INT,
    Date_in DATE,
    Date_out date,
    Payment_method VARCHAR(50),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Room_type_ID) REFERENCES Room_type(Room_type_ID)
);

-- Create Room Table
CREATE TABLE Room (
    Room_ID INT PRIMARY KEY,
    Room_number VARCHAR(10),
    Room_type_ID INT,
    FOREIGN KEY (Room_type_ID) REFERENCES Room_type(Room_type_ID)
);

Alter table Ticket_type
Add column Seat_section_with_in_each_category Varchar (50);

	Alter table Room_transaction
    Drop column Date_in,
    Drop column Date_out,
    Add column Date_in Varchar (50),
    Add column Date_out Varchar (50);
    
    CREATE TABLE Room_transaction (
    Customer_ID INT,
    Room_type_ID INT,
    Date_in Varchar (50),
    Date_out Varchar (50),
    Payment_method VARCHAR(50),
    Primary key (Customer_ID,Room_type_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Room_type_ID) REFERENCES Room_type(Room_type_ID)
);
    
    Create table Transaction (
    Customer_ID INT,
    Room_type_ID INT,
    Date_in Varchar (50),
    Date_out Varchar (50),
    Payment_method VARCHAR(50),
    Ticket_type_ID INT,
    Ticket_type_bought INT,
    PRIMARY KEY (Customer_ID, Ticket_type_ID, Room_type_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Ticket_type_ID) REFERENCES Ticket_type(Ticket_type_ID),
    FOREIGN KEY (Room_type_ID) REFERENCES Room_type(Room_type_ID)
    );
    
    Drop table ticket_transaction;
    
    Drop table room_transaction;