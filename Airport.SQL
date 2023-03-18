
/******************************************************************************/
/****************************** DDL SECTION ***********************************/
/******************************************************************************/


/**************************** AIRPORT DATABASE ********************************/
/******************************************************************************/

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'AirportBase')
BEGIN
    CREATE DATABASE AirportBase
END
GO

USE AirportBase
GO

/********************* Create a table of Model Planes *************************/
/******************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ModelPlanes' and xtype='U')
BEGIN
	CREATE TABLE ModelPlanes(
		Id nvarchar(20) NOT NULL PRIMARY KEY,
		Name nvarchar(100) NOT NULL,
		Seats int NOT NULL)
END
GO

/************************ Create a table of Planes ****************************/
/******************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Planes' and xtype='U')
BEGIN
	CREATE TABLE Planes(
		Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
		SerialNumber nvarchar(50) NOT NULL,
		Model nvarchar(20) NOT NULL
		CONSTRAINT FK_Planes_PlaneModels FOREIGN KEY (Model)
			REFERENCES ModelPlanes (Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
	)
END
GO

/************************ Create a table of Pilots ****************************/
/******************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Pilots' and xtype='U')
BEGIN
	CREATE TABLE Pilots(
		Id int NOT NULL PRIMARY KEY,
		Name nvarchar(100) NOT NULL,
		Age int NOT NULL)
END
GO

/****************** Create a table of Model Planes Pilots *********************/
/******************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ModelPlanesPilots' and xtype='U')
BEGIN
	CREATE TABLE ModelPlanesPilots(
		Model nvarchar(20) NOT NULL,
		Pilot int NOT NULL,
		CONSTRAINT PK_Model_Pilot PRIMARY KEY (Model, Pilot),
		CONSTRAINT FK_ModelPlanesPilots_ModelPlanes FOREIGN KEY (Model)
			REFERENCES ModelPlanes (Id),
		CONSTRAINT FK_ModelPlanesPilots_Pilots FOREIGN KEY (Pilot)
			REFERENCES Pilots (Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
	)
END
GO

/********************* Create a table of Flight history ***********************/
/******************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FlightHistory' and xtype='U')
BEGIN
	CREATE TABLE FlightHistory(
		Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
		Plane int NOT NULL,
		Pilot1 int NOT NULL,
		Pilot2 int NOT NULL,
		Finished bit NOT NULL,
		CONSTRAINT FK_FlightHistory_Planes FOREIGN KEY (Plane)
			REFERENCES Planes (Id),
		CONSTRAINT FK_FlightHistory_Pilots_1 FOREIGN KEY (Pilot1)
			REFERENCES Pilots (Id),
		CONSTRAINT FK_FlightHistory_Pilots_2 FOREIGN KEY (Pilot2)
			REFERENCES Pilots (Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
	)
END
GO


/******************************************************************************/
/****************************** DML SECTION ***********************************/
/******************************************************************************/

/* Inputting test data */

INSERT INTO ModelPlanes (Id, Name, Seats) VALUES 
	('Boeing_747', 'Boeing 747', 467),
	('Airbus_A320', 'Airbus A320', 186)
GO

INSERT INTO Planes (SerialNumber, Model) VALUES 
	('B-01', 'Boeing_747'),
	('B-02', 'Boeing_747'),
	('A-01', 'Airbus_A320'),
	('A-02', 'Airbus_A320'),
	('A-03', 'Airbus_A320'),
	('A-04', 'Airbus_A320'),
	('A-05', 'Airbus_A320')
GO

INSERT INTO Pilots (Id, Name, Age) VALUES 
	(101, 'Theodore Preston', 47),
	(102, 'Brian Simon', 29),
	(201, 'Gordon Goodwin', 32),
	(301, 'Neil Walker', 30),
	(302, 'Matilda Higgins', 35),
	(303, 'Owen Singleton', 42),
	(304, 'Lee Porter', 36),
	(305, 'Anis Evans', 26)
GO

INSERT INTO ModelPlanesPilots (Model, Pilot) VALUES 
	('Boeing_747', 101),
	('Airbus_A320', 101),
	('Boeing_747', 201),
	('Airbus_A320', 201),
	('Boeing_747', 202),
	('Airbus_A320', 301),
	('Airbus_A320', 302),
	('Airbus_A320', 303),
	('Airbus_A320', 304),
	('Airbus_A320', 305)
GO

