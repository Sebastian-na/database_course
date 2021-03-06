-- -----------------------------------------------------------------------------
-- BD1-avance5-grupo12-MSQL.sql
-- Objetivo: Practicar la creación de funciones
-- Autores:  Breyner Ciro Otero, Juan Vahos Duque, Sebastián Castañeda García, Omar Nicolas Guerrero, Chaparro David Mackenzie
-- Fecha:    6/25/2022
-- Ambiente: SQL Server
-- -----------------------------------------------------------------------------

/* Database creation */
CREATE TABLE Manager (
id INT NOT NULL IDENTITY(1, 1),
name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
CONSTRAINT pk_manager PRIMARY KEY (id)
);

CREATE TABLE Submanagers (
id INT NOT NULL IDENTITY(1, 1),
name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
boss_id INT NOT NULL,
CONSTRAINT pk_submanagers PRIMARY KEY (id),
CONSTRAINT fk_submanagers_manager FOREIGN KEY (boss_id) REFERENCES Manager(id)
);

CREATE TABLE Branchmanagers (
id INT NOT NULL IDENTITY(1, 1),
name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
boss_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (boss_id) REFERENCES Submanagers(id)
);

CREATE TABLE Departmentdirectors (
id INT NOT NULL IDENTITY(1, 1),
name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
boss_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (boss_id) REFERENCES Branchmanagers(id)
);

CREATE TABLE Branches(
id INT NOT NULL IDENTITY(1, 1),
city VARCHAR(100) NOT NULL,
phone VARCHAR(100) NOT NULL,
branch_manager_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (branch_manager_id) REFERENCES Branchmanagers(id)
);

CREATE TABLE Departments(
id INT NOT NULL IDENTITY(1, 1),
branch_id INT NOT NULL,
department_director_id INT NOT NULL,
name VARCHAR(100) NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (branch_id) REFERENCES Branches(id),
FOREIGN KEY (department_director_id) REFERENCES Departmentdirectors(id)
);

CREATE TABLE Salespeople(
id INT NOT NULL IDENTITY(1, 1),
name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
phone VARCHAR(100) NOT NULL,
salary INT NOT NULL,
commission INT DEFAULT 0,
hire_date DATETIME NOT NULL DEFAULT GETDATE(),
promotion_date DATETIME NOT NULL DEFAULT GETDATE(),
termination_date DATETIME,
active BIT DEFAULT 1 NOT NULL,
department_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (department_id) REFERENCES Departments(id)
);

CREATE TABLE Customers(
id INT NOT NULL IDENTITY(1, 1),
name VARCHAR(100) NOT NULL,
nit INT UNIQUE NOT NULL,
address VARCHAR(100) NOT NULL,
phone VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
manager_name VARCHAR(100) NOT NULL,
manager_last_name VARCHAR(100) NOT NULL,
salesperson_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (salesperson_id) REFERENCES Salespeople(id)
);

CREATE TABLE Meetings(
id INT NOT NULL IDENTITY(1, 1),
meeting_date DATETIME NOT NULL,
customer_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (customer_id) REFERENCES Customers(id)
);

CREATE TABLE Sales(
id INT NOT NULL IDENTITY(1, 1),
customer_id INT NOT NULL,
sale_date DATETIME NOT NULL DEFAULT GETDATE(),
PRIMARY KEY (id),
FOREIGN KEY (customer_id) REFERENCES Customers(id)
);

CREATE TABLE Purchases(
id INT NOT NULL IDENTITY(1, 1),
branch_id INT NOT NULL,
purchase_date DATETIME NOT NULL DEFAULT GETDATE(),
arrive_date DATETIME,
PRIMARY KEY (id),
FOREIGN KEY (branch_id) REFERENCES Branches(id)
);

CREATE TABLE Providers(
id INT NOT NULL IDENTITY(1, 1),
name VARCHAR(100) NOT NULL,
nit INT NOT NULL,
address VARCHAR(100) NOT NULL,
phone VARCHAR(100) NOT NULL,
manager_name VARCHAR(100) NOT NULL,
manager_last_name VARCHAR(100) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE Products(
id INT NOT NULL IDENTITY(1, 1),
name VARCHAR(100) NOT NULL,
description varchar(200) NOT NULL,
purchase_price INT NOT NULL,
sale_price INT NOT NULL,
market_division VARCHAR(100) NOT NULL,
provider_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (provider_id) REFERENCES Providers(id)
);

CREATE TABLE Purchases_products(
id INT NOT NULL IDENTITY(1, 1),
purchase_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (purchase_id) REFERENCES Purchases(id),
FOREIGN KEY (product_id) REFERENCES Products(id)
);

CREATE TABLE Products_stocks(
id INT NOT NULL IDENTITY(1, 1),
product_id INT NOT NULL,
stock_id INT NOT NULL,
quantity INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (product_id) REFERENCES Products(id),
FOREIGN KEY (stock_id) REFERENCES Branches(id)
);

CREATE TABLE Sales_products(
id INT NOT NULL IDENTITY(1, 1),
sale_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (sale_id) REFERENCES Sales(id),
FOREIGN KEY (product_id) REFERENCES Products(id)
);

/*Create views for each table*/
CREATE VIEW V_Manager AS SELECT * FROM Manager;
CREATE VIEW V_Submanagers AS SELECT * FROM Submanagers;
CREATE VIEW V_Branchmanagers AS SELECT * FROM Branchmanagers;
CREATE VIEW V_Departmentdirectors AS SELECT * FROM Departmentdirectors;
CREATE VIEW V_Branches AS SELECT * FROM Branches;
CREATE VIEW V_Departments AS SELECT * FROM Departments;
CREATE VIEW V_Salespeople AS SELECT * FROM Salespeople;
CREATE VIEW V_Customers AS SELECT * FROM Customers;
CREATE VIEW V_Meetings AS SELECT * FROM Meetings;
CREATE VIEW V_Sales AS SELECT * FROM Sales;
CREATE VIEW V_Purchases AS SELECT * FROM Purchases;
CREATE VIEW V_Providers AS SELECT * FROM Providers;
CREATE VIEW V_Products AS SELECT * FROM Products;
CREATE VIEW V_Purchases_products AS SELECT * FROM Purchases_products;
CREATE VIEW V_Products_stocks AS SELECT * FROM Products_stocks;
CREATE VIEW V_Sales_products AS SELECT * FROM Sales_products;

GRANT SELECT, INSERT, UPDATE ON V_Manager TO grupo12;
GRANT SELECT, INSERT, UPDATE ON V_Submanagers TO grupo12;
GRANT SELECT, INSERT, UPDATE ON V_Branchmanagers TO grupo12;
GRANT SELECT, INSERT, UPDATE ON V_Departmentdirectors TO grupo12;
GRANT SELECT, INSERT, UPDATE ON V_Branches TO grupo12;
GRANT SELECT, INSERT, UPDATE ON V_Departments TO grupo12;
GRANT SELECT, INSERT, UPDATE ON V_Salespeople TO grupo12;
GRANT SELECT, INSERT, UPDATE ON V_Customers TO grupo12;
GRANT SELECT, INSERT, UPDATE ON V_Meetings TO grupo12;
GRANT SELECT, INSERT, UPDATE ON V_Sales TO grupo12;
GRANT SELECT, INSERT, UPDATE ON V_Purchases TO grupo12;
GRANT SELECT, INSERT, UPDATE ON V_Providers TO grupo12;
GRANT SELECT, INSERT, UPDATE ON V_Products TO grupo12;
GRANT SELECT, INSERT, UPDATE ON V_Purchases_products TO grupo12;
GRANT SELECT, INSERT, UPDATE ON V_Products_stocks TO grupo12;
GRANT SELECT, INSERT, UPDATE ON V_Sales_products TO grupo12;

/*Insert data in manager table*/
INSERT INTO user.V_Manager(name, last_name) VALUES ('Juan', 'Perez');

/*Insert data in submanager table*/
INSERT INTO user.V_Submanagers(name, last_name, boss_id) VALUES ('Pedro', 'Perez', 1);
INSERT INTO user.V_Submanagers(name, last_name, boss_id) VALUES ('Juana', 'Perez', 1);
INSERT INTO user.V_Submanagers(name, last_name, boss_id) VALUES ('Maria', 'Perez', 1);
INSERT INTO user.V_Submanagers(name, last_name, boss_id) VALUES ('Ana', 'Perez', 1);

/*Insert data in branchmanager table*/
INSERT INTO user.V_Branchmanagers (name, last_name, boss_id) values ('Jessie', 'Faccini', 1);
INSERT INTO user.V_Branchmanagers (name, last_name, boss_id) values ('Magdalena', 'Toppas', 1);
INSERT INTO user.V_Branchmanagers (name, last_name, boss_id) values ('Meyer', 'Kybert', 1);
INSERT INTO user.V_Branchmanagers (name, last_name, boss_id) values ('Hatti', 'Alsford', 4);
INSERT INTO user.V_Branchmanagers (name, last_name, boss_id) values ('Susy', 'Orro', 4);
INSERT INTO user.V_Branchmanagers (name, last_name, boss_id) values ('Wilhelmine', 'Eldritt', 2);
INSERT INTO user.V_Branchmanagers (name, last_name, boss_id) values ('Peta', 'Mowling', 1);
INSERT INTO user.V_Branchmanagers (name, last_name, boss_id) values ('Morna', 'Bonnavant', 1);
INSERT INTO user.V_Branchmanagers (name, last_name, boss_id) values ('Vannie', 'Isacke', 3);
INSERT INTO user.V_Branchmanagers (name, last_name, boss_id) values ('Pen', 'Querrard', 2);

/*Insert data in departmentdirectors table*/
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Pennie', 'Korneichik', 2);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Crystal', 'Elesander', 10);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Marchelle', 'Wyer', 7);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Sigfried', 'Ivanchin', 4);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Kalinda', 'Piggens', 9);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Scott', 'Kiljan', 1);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Buck', 'Cruddace', 2);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Sigismundo', 'O''Calleran', 5);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Elbert', 'Van der Spohr', 7);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Georgiana', 'Rainbow', 6);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Deane', 'Vernazza', 10);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Walton', 'Arrigo', 5);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Keri', 'Samworth', 4);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Idalina', 'Jeram', 4);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Isis', 'Baccus', 10);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Filmer', 'Faulconer', 1);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Ezequiel', 'Mathiot', 3);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Kippy', 'Dayer', 2);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Meier', 'Bullivant', 5);
INSERT INTO user.V_Departmentdirectors (name, last_name, boss_id) values ('Loralee', 'Bartolome', 3);

/*insert data in Branches table*/
INSERT INTO user.V_Branches (city, phone, branch_manager_id) values ('Zhoukou', '579-823-0606', 1);
INSERT INTO user.V_Branches (city, phone, branch_manager_id) values ('Dadus', '345-555-5340', 2);
INSERT INTO user.V_Branches (city, phone, branch_manager_id) values ('Longquan', '731-403-7874', 3);
INSERT INTO user.V_Branches (city, phone, branch_manager_id) values ('Madan', '815-185-2693', 4);
INSERT INTO user.V_Branches (city, phone, branch_manager_id) values ('Dolní Počernice', '316-141-5444', 5);
INSERT INTO user.V_Branches (city, phone, branch_manager_id) values ('Stari Grad', '646-768-8201', 6);
INSERT INTO user.V_Branches (city, phone, branch_manager_id) values ('Eido', '738-792-0841', 7);
INSERT INTO user.V_Branches (city, phone, branch_manager_id) values ('Sirnarasa', '199-609-9957', 8);
INSERT INTO user.V_Branches (city, phone, branch_manager_id) values ('Krajan', '407-308-8262', 9);
INSERT INTO user.V_Branches (city, phone, branch_manager_id) values ('Qom', '617-832-0005', 10);

/*insert data in Departments table*/
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (10, 1, 'Music');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (3, 2, 'Jewelry');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (4, 3, 'Tools');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (5, 4, 'Automotive');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (6, 5, 'Home');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (7, 6, 'Outdoors');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (10, 7, 'Baby');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (8, 8, 'Grocery');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (9, 9, 'Games');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (5, 10, 'Baby');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (2, 11, 'Clothing');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (1, 12, 'Movies');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (7, 13, 'Beauty');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (9, 14, 'Games');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (1, 15, 'Computers');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (6, 16, 'Garden');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (7, 17, 'Automotive');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (4, 18, 'Garden');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (7, 19, 'Toys');
INSERT INTO user.V_Departments (branch_id, department_director_id, name) values (2, 20, 'Grocery');

/* Insert data in Salespeople table */
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Christye', 'Millar', '864-469-5472', 960804, 176875, 1);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Germaine', 'De Francesco', '530-265-2571', 807087, null, 2);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Adelaida', 'Grisedale', '413-214-8145', 1193065, 177254, 3);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Carlo', 'Demschke', '579-942-0007', 983476, null, 4);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Hubey', 'Seefus', '981-581-4698', 1052423, 193961, 5);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Noelle', 'Dubbin', '540-894-4141', 1168271, 132327, 6);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Care', 'Tarpey', '770-159-5398', 984800, 153520, 7);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Sherilyn', 'Normant', '513-532-6874', 1153051, 180247, 8);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Cecilio', 'Heifer', '524-469-0693', 886388, null, 9);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Vida', 'Parzizek', '945-355-3724', 863963, null, 10);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Jarret', 'Briztman', '549-749-7951', 1103858, 198109, 11);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Colin', 'Sweedy', '177-152-1427', 828660, 112246, 12);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Meghann', 'Castagnet', '524-187-6050', 1190360, null, 13);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Lia', 'Stellin', '401-613-7341', 1133027, 134290, 14);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Ortensia', 'Tinkler', '990-122-2183', 801540, null, 15);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Ulrikaumeko', 'Gillice', '448-843-0293', 1140951, 116700, 16);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Kipper', 'O''Noulane', '585-990-6850', 936047, null, 17);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Bessie', 'Martine', '809-595-8427', 1089849, null, 18);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Briana', 'Newbury', '233-209-4711', 915130, 168645, 19);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Marnia', 'Giacubo', '513-228-6472', 1042471, 187667, 20);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Niki', 'Lightowler', '962-955-4622', 1010510, null, 1);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Danyelle', 'Moyles', '921-702-8114', 828379, 165196, 2);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Kiersten', 'Dornan', '636-256-4440', 1180206, 107855, 3);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Bone', 'Garbutt', '833-352-1657', 1037469, null, 4);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Ortensia', 'Dobbing', '316-269-5540', 926670, null, 5);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Imogene', 'Gareisr', '440-282-7354', 891349, 104914, 6);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Alejoa', 'Maskill', '244-984-3585', 966609, null, 7);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Kelcie', 'Boatswain', '404-140-4133', 1045007, 109090, 8);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Antonino', 'Vanichev', '483-721-9413', 1132384, 104300, 9);
INSERT INTO user.V_Salespeople (name, last_name, phone, salary, commission, department_id) values ('Fianna', 'MacAughtrie', '871-586-9003', 1175114, null, 10);

/*Insert data in Customers table*/

INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Aguistin', 2000, '9 Armistice Park', '889-596-8288', 'ebassindale0@businessinsider.com', 'Essie', 'Bassindale', 1);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Boony', 2001, '9313 Brickson Park Parkway', '624-619-8743', 'hmccomiskey1@delicious.com', 'Harriett', 'McComiskey', 12);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Gradey', 2002, '417 Golf View Crossing', '525-835-6597', 'kmorsom2@163.com', 'Kaiser', 'Morsom', 3);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Egbert', 2003, '5 Wayridge Road', '993-934-9887', 'sverma3@networkadvertising.org', 'Spence', 'Verma', 4);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Emmalee', 2004, '7016 Chive Court', '903-778-5737', 'sblodg4@gmpg.org', 'Susan', 'Blodg', 5);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Care', 2006, '00 Mesta Junction', '544-908-3587', 'ycoull6@mit.edu', 'Yorker', 'Coull', 6);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Colly', 2007, '99228 Eliot Road', '305-904-5050', 'ggilhooly7@amazonaws.com', 'Gottfried', 'Gilhooly', 7);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Moss', 2008, '65 Jenna Center', '106-288-0484', 'kphilpott8@godaddy.com', 'Karney', 'Philpott', 8);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Renado', 2010, '0 Clarendon Point', '612-611-5836', 'bovernella@independent.co.uk', 'Beatrice', 'Overnell', 9);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Annnora', 2011, '6965 Lakewood Gardens Drive', '912-949-1012', 'gsanchob@blog.com', 'Gordan', 'Sancho', 10);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Evered', 2012, '97908 Lyons Crossing', '920-377-7476', 'vbollinsc@auda.org.au', 'Violetta', 'Bollins', 11);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Brooks', 2013, '336 Elgar Street', '244-108-3250', 'mnoorwoodd@paypal.com', 'Myrlene', 'Noorwood', 12);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Carmelita', 2014, '0 Riverside Alley', '243-291-1739', 'eorre@samsung.com', 'Esteban', 'Orr', 13);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Nerta', 2015, '98498 Linden Street', '934-829-4882', 'ijentzschf@prlog.org', 'Iris', 'Jentzsch', 14);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('York', 2016, '65 Golf Course Park', '830-633-1217', 'tchipleng@time.com', 'Townsend', 'Chiplen', 15);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Kippar', 2022, '719 Cascade Pass', '723-326-8541', 'lmushetm@prlog.org', 'Lind', 'Mushet', 16);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Sandye', 2024, '14 La Follette Place', '582-454-3484', 'bmurdeno@dell.com', 'Belicia', 'Murden', 17);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Alano', 2025, '801 Katie Trail', '934-877-6951', 'amenlovep@lycos.com', 'Adda', 'Menlove', 18);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Darb', 2028, '37379 Mcbride Court', '471-774-1556', 'cyushachkovs@newyorker.com', 'Cale', 'Yushachkov', 19);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Adriane', 2030, '0536 West Parkway', '666-836-8740', 'rchanneru@unesco.org', 'Romy', 'Channer', 20);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Caesar', 2031, '25 Manufacturers Pass', '189-175-5198', 'abillinghamv@discovery.com', 'Aura', 'Billingham', 21);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Marybelle', 2033, '4329 Butternut Crossing', '770-552-3102', 'ucowx@usatoday.com', 'Ulrich', 'Cow', 22);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Durward', 2035, '20819 Almo Lane', '842-450-1578', 'ibwyz@macromedia.com', 'Ilyse', 'Bwy', 23);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Rudolf', 2037, '00361 Mcguire Plaza', '582-489-5012', 'aprati11@wikipedia.org', 'Andrej', 'Prati', 24);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Audy', 2038, '8221 Hoffman Circle', '408-730-2262', 'glints12@wordpress.com', 'Grady', 'Lints', 25);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Rhody', 2041, '0150 Thierer Center', '225-539-5956', 'sgregolin15@addtoany.com', 'Stirling', 'Gregolin', 26);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Merrilee', 2043, '08 Ridgeway Center', '307-132-9375', 'pbello17@tinypic.com', 'Penny', 'Bello', 27);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Herrick', 2045, '22 Tennyson Court', '951-553-7989', 'rborrott19@unicef.org', 'Randie', 'Borrott', 28);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Sharline', 2047, '66 Gerald Circle', '713-361-4464', 'fmargeram1b@mapquest.com', 'Forester', 'Margeram', 29);
INSERT INTO user.V_Customers (name, nit, address, phone, email, manager_name, manager_last_name, salesperson_id) values ('Tab', 2048, '2 Milwaukee Avenue', '798-862-5262', 'rdunseath1c@rambler.ru', 'Ros', 'Dunseath', 30);

/*Insert data in Meetings table*/
INSERT INTO user.V_Meetings (meeting_date, customer_id) values ('2022-11-03 21:02:44', 1);
INSERT INTO user.V_Meetings (meeting_date, customer_id) values ('2022-12-03 21:02:44', 2);
INSERT INTO user.V_Meetings (meeting_date, customer_id) values ('2022-10-03 21:02:44', 3);
INSERT INTO user.V_Meetings (meeting_date, customer_id) values ('2022-02-03 21:02:44', 4);
INSERT INTO user.V_Meetings (meeting_date, customer_id) values ('2023-01-03 21:02:44', 5);
INSERT INTO user.V_Meetings (meeting_date, customer_id) values ('2023-04-03 21:02:44', 6);
INSERT INTO user.V_Meetings (meeting_date, customer_id) values ('2023-06-03 21:02:44', 7);

/*Insert data in Sales table*/
INSERT INTO user.V_Sales (customer_id, sale_date) values (1, '2022-02-03 21:02:44');
INSERT INTO user.V_Sales (customer_id, sale_date) values (2, '2022-01-03 21:02:44');
INSERT INTO user.V_Sales (customer_id, sale_date) values (3, '2022-02-03 21:02:44');
INSERT INTO user.V_Sales (customer_id, sale_date) values (4, '2021-02-03 21:02:44');
INSERT INTO user.V_Sales (customer_id, sale_date) values (5, '2020-02-03 21:02:44');
INSERT INTO user.V_Sales (customer_id, sale_date) values (6, '2019-02-03 21:02:44');
INSERT INTO user.V_Sales (customer_id, sale_date) values (7, '2018-02-03 21:02:44');

/*Insert data in Purchases table*/

INSERT INTO user.V_Purchases (branch_id, purchase_date) values (1, '2018-02-03 21:02:44');
INSERT INTO user.V_Purchases (branch_id, purchase_date) values (2, '2018-02-03 21:02:44');
INSERT INTO user.V_Purchases (branch_id, purchase_date) values (3, '2018-02-03 21:02:44');
INSERT INTO user.V_Purchases (branch_id, purchase_date) values (4, '2018-02-03 21:02:44');
INSERT INTO user.V_Purchases (branch_id, purchase_date) values (5, '2018-02-03 21:02:44');
INSERT INTO user.V_Purchases (branch_id, purchase_date, arrive_date) values (6, '2018-02-03 21:02:44', '2022-02-03 21:02:44');
INSERT INTO user.V_Purchases (branch_id, purchase_date, arrive_date) values (7, '2021-02-03 21:02:44', '2022-02-03 21:02:44');

/*Insert data in Providers table*/
INSERT INTO user.V_Providers(name, nit, address, phone, manager_name, manager_last_name) values ('Alfreds Futterkiste', 83745, 'Obere Str. 57', '030-0074315', 'Maria Anders', 'Anders');
INSERT INTO user.V_Providers(name, nit, address, phone, manager_name, manager_last_name) values ('Centro comercial Moctezuma', 1532, 'Sierras de Granada 9993', '967-003-7462', 'Francisco Chang', 'Chang');
INSERT INTO user.V_Providers(name, nit, address, phone, manager_name, manager_last_name) values ('Ernst Handel', 3211, 'Kirchgasse 6', '030-0074315', 'Roland Mendel', 'Mendel');

/*Insert data in Products table*/
INSERT INTO user.V_Products(name, description, purchase_price, sale_price, market_division, provider_id) values ('Chai', 'Instant coffee', 18.00, 19.00, 'Beverages', 1);
INSERT INTO user.V_Products(name, description, purchase_price, sale_price, market_division, provider_id) values ('Chang', 'Bubble tea', 20.00, 22.00, 'Beverages', 2);
INSERT INTO user.V_Products(name, description, purchase_price, sale_price, market_division, provider_id) values ('Aniseed Syrup', 'Aniseed syrup', 10.00, 12.00, 'Condiments', 3);
INSERT INTO user.V_Products(name, description, purchase_price, sale_price, market_division, provider_id) values ('Chef Anton''s Cajun Seasoning', 'Chef Anton''s Cajun Seasoning', 22.00, 22.00, 'Condiments', 3);
INSERT INTO user.V_Products(name, description, purchase_price, sale_price, market_division, provider_id) values ('Chef Anton''s Gumbo Mix', 'Chef Anton''s Gumbo Mix', 21.35, 23.25, 'Condiments', 3);
INSERT INTO user.V_Products(name, description, purchase_price, sale_price, market_division, provider_id) values ('Grandma''s Boysenberry Spread', 'Grandma''s Boysenberry Spread', 25.00, 25.00, 'Condiments', 3);
INSERT INTO user.V_Products(name, description, purchase_price, sale_price, market_division, provider_id) values ('Northwoods Cranberry Sauce', 'Northwoods Cranberry Sauce', 40.00, 40.00, 'Condiments', 3);
INSERT INTO user.V_Products(name, description, purchase_price, sale_price, market_division, provider_id) values ('Mishi Kobe Niku', 'Mishi Kobe Niku', 97.00, 97.00, 'Meat/Poultry', 1);
INSERT INTO user.V_Products(name, description, purchase_price, sale_price, market_division, provider_id) values ('Ikura', 'Ikura', 31.00, 31.00, 'Seafood', 1);
INSERT INTO user.V_Products(name, description, purchase_price, sale_price, market_division, provider_id) values ('Queso Cabrales', 'Queso Cabrales', 21.00, 21.00, 'Dairy Products', 2);

/*Insert data in Purchases_products table*/
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (1, 1, 50);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (1, 2, 30);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (1, 3, 15);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (1, 4, 30);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (2, 5, 45);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (2, 6, 15);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (2, 7, 15);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (3, 8, 40);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (3, 9, 20);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (3, 10, 30);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (4, 1, 25);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (4, 2, 25);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (4, 3, 30);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (5, 4, 45);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (5, 5, 30);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (5, 6, 15);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (6, 7, 30);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (6, 8, 15);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (6, 9, 45);
INSERT INTO user.V_Purchases_products(purchase_id, product_id, quantity) values (7, 10, 15);

/*Insert data in Products_stocks table*/
INSERT INTO user.V_Products_stocks(product_id, stock_id, quantity) values (1, 1, 50);
INSERT INTO user.V_Products_stocks(product_id, stock_id, quantity) values (2, 1, 50);
INSERT INTO user.V_Products_stocks(product_id, stock_id, quantity) values (3, 1, 50);
INSERT INTO user.V_Products_stocks(product_id, stock_id, quantity) values (2, 2, 30);
INSERT INTO user.V_Products_stocks(product_id, stock_id, quantity) values (3, 2, 30);
INSERT INTO user.V_Products_stocks(product_id, stock_id, quantity) values (3, 3, 15);
INSERT INTO user.V_Products_stocks(product_id, stock_id, quantity) values (4, 3, 30);
INSERT INTO user.V_Products_stocks(product_id, stock_id, quantity) values (4, 4, 30);
INSERT INTO user.V_Products_stocks(product_id, stock_id, quantity) values (5, 4, 45);
INSERT INTO user.V_Products_stocks(product_id, stock_id, quantity) values (6, 4, 15);
INSERT INTO user.V_Products_stocks(product_id, stock_id, quantity) values (7, 5, 15);
INSERT INTO user.V_Products_stocks(product_id, stock_id, quantity) values (8, 5, 40);
INSERT INTO user.V_Products_stocks(product_id, stock_id, quantity) values (9, 6, 20);
INSERT INTO user.V_Products_stocks(product_id, stock_id, quantity) values (10, 7, 30);
INSERT INTO user.V_Products_stocks(product_id, stock_id, quantity) values (10, 8, 30);
INSERT INTO user.V_Products_stocks(product_id, stock_id, quantity) values (10, 9, 30);
INSERT INTO user.V_Products_stocks(product_id, stock_id, quantity) values (10, 10, 30);

/*Insert data in Sales_products*/
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (1, 1, 50);
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (1, 2, 30);
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (2, 3, 15);
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (2, 4, 30);
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (3, 5, 45);
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (3, 6, 15);
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (3, 7, 15);
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (4, 8, 40);
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (4, 9, 20);
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (4, 10, 30);
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (5, 1, 25);
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (5, 2, 25);
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (5, 3, 30);
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (6, 4, 45);
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (6, 5, 30);
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (6, 6, 15);
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (7, 7, 30);
INSERT INTO user.V_Sales_products(sale_id, product_id, quantity) values (7, 8, 15);


/*-------------------------------------------------------------------------------*/
/* Business rules */

/* Duplicate salespeople id yields error */
INSERT INTO user.V_Salespeople (id, name, last_name, phone, salary, commission, department_id) values (2, 'Fianna', 'MacAughtrie', '871-586-9003', 1175114, null, 10);

/* Insert a product with a provider that does not exist */
INSERT INTO user.V_Products(name, description, purchase_price, sale_price, market_division, provider_id) values ('Chai', 'Instant coffee', 18.00, 19.00, 'Beverages', 100);

/*Useful functions*/
CREATE FUNCTION GET_SALES()
RETURNS int
AS
BEGIN
  DECLARE @sales INT;
  SELECT @sales = SUM(p.SALE_PRICE * vsp.QUANTITY) 
  FROM user.V_SALES_PRODUCTS vsp 
  INNER JOIN user.PRODUCTS p ON vsp.PRODUCT_ID = p.ID;
  RETURN @sales;
END;

CREATE FUNCTION GET_SALES_PROFIT()
RETURNS int
AS
BEGIN
  DECLARE @income INT; 
  SELECT @income = SUM(p.SALE_PRICE * vsp.QUANTITY)
  FROM user.V_SALES_PRODUCTS vsp 
  INNER JOIN user.PRODUCTS p ON vsp.PRODUCT_ID = p.ID;
  
  DECLARE @costs INT;
  SELECT @costs = SUM(p.PURCHASE_PRICE * vsp.QUANTITY)
  FROM user.V_SALES_PRODUCTS vsp 
  INNER JOIN user.PRODUCTS p ON vsp.PRODUCT_ID = p.ID;
 
 RETURN @income - @costs;
END;

CREATE FUNCTION GET_TOTAL_SALESPEOPLE()
RETURNS INT
AS
BEGIN
 DECLARE @total INT;
 SELECT @total = COUNT(id) FROM user.SALESPEOPLE;
 RETURN @total;
END;

/*
DELETE TABLES
*/
DROP TABLE SALES_PRODUCTS;
DROP TABLE PRODUCTS_STOCKS;
DROP TABLE PURCHASES_PRODUCTS;
DROP TABLE PRODUCTS;
DROP TABLE PROVIDERS;
DROP TABLE PURCHASES;
DROP TABLE SALES;
DROP TABLE MEETINGS;
DROP TABLE CUSTOMERS;
DROP TABLE SALESPEOPLE;
DROP TABLE DEPARTMENTS;
DROP TABLE BRANCHES;
DROP TABLE DEPARTMENTDIRECTORS; 
DROP TABLE BRANCHMANAGERS; 
DROP TABLE SUBMANAGERS;
DROP TABLE MANAGER;

/*
DELETE VIEWS
*/
DROP VIEW V_SALES_PRODUCTS;
DROP VIEW V_PRODUCTS_STOCKS;
DROP VIEW V_PURCHASES_PRODUCTS;
DROP VIEW V_PRODUCTS;
DROP VIEW V_PROVIDERS;
DROP VIEW V_PURCHASES;
DROP VIEW V_SALES;
DROP VIEW V_MEETINGS;
DROP VIEW V_CUSTOMERS;
DROP VIEW V_SALESPEOPLE;
DROP VIEW V_DEPARTMENTS;
DROP VIEW V_BRANCHES;
DROP VIEW V_DEPARTMENTDIRECTORS; 
DROP VIEW V_BRANCHMANAGERS; 
DROP VIEW V_SUBMANAGERS;
DROP VIEW V_MANAGER;

/*DELETE FUNCTIONS*/
DROP FUNCTION GET_SALES;
DROP FUNCTION GET_SALES_PROFIT;
DROP FUNCTION GET_TOTAL_SALESPEOPLE;