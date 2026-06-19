CREATE DATABASE sales_management_task;

USE sales_management_task;

create table productlines (
    productLine varchar(50) primary key,
    textDescription varchar(4000) DEFAULT NULL,
    htmlDescription mediumtext DEFAULT NULL,
    -- assumed to keep the image path
    image BLOB DEFAULT NULL
);

create table products (
    productCode varchar(15) primary key,
    productName varchar(70) NOT NULL,
    productLine varchar(50) NOT NULL,
    productScale varchar(10) NOT NULL,
    productVendor varchar(50) NOT NULL,
    productDescription TEXT NOT NULL,
    quantityInStock SMALLINT NOT NULL,
    buyPrice decimal(10, 2) NOT NULL,
    MSRP decimal(10, 2) NOT NULL,
    foreign key (productLine) references productlines (productLine)
);

create table offices (
    officeCode int primary key,
    city varchar(50) NOT NULL,
    phone varchar(20) NOT NULL,
    addressLine1 varchar(50) NOT NULL,
    addressLine2 varchar(50) DEFAULT NULL,
    state varchar(50) DEFAULT NULL,
    country varchar(30) NOT NULL,
    postalCode VARCHAR(15) NOT NULL,
    territory varchar(50) NOT NULL
);

create table employees (
    employeeNumber int primary key,
    lastName varchar(50) NOT NULL,
    firstName varchar(50) NOT NULL,
    extension varchar(10) NOT NULL,
    email varchar(100) NOT NULL,
    officeCode int NOT NULL,
    reportsTo int DEFAULT NULL,
    jobTitle varchar(50) NOT NULL,
    foreign key (reportsTo) references employees (employeeNumber),
    foreign key (officeCode) references offices (officeCode)
);

create table customers (
    customerNumber int primary key,
    customerName varchar(50) NOT NULL,
    contactLastName varchar(20) NOT NULL,
    contactFirstName varchar(20) NOT NULL,
    phone varchar(50) NOT NULL,
    addressLine1 varchar(50) NOT NULL,
    addressLine2 varchar(50) DEFAULT NULL,
    city varchar(50) NOT NULL,
    state varchar(50) DEFAULT NULL,
    postalCode VARCHAR(15) DEFAULT NULL,
    country varchar(50) NOT NULL,
    salesRepEmployeeNumber int DEFAULT NULL,
    creditLimit decimal(10, 2) DEFAULT NULL,
    foreign key (salesRepEmployeeNumber) references employees (employeeNumber)
);

create table orders (
    orderNumber int primary key,
    orderDate date NOT NULL,
    requiredDate date NOT NULL,
    shippedDate date DEFAULT NULL,
    status varchar(15) NOT NULL,
    comments TEXT DEFAULT NULL,
    customerNumber int NOT NULL,
    foreign key (customerNumber) references customers (customerNumber)
);

create table orderdetails (
    orderNumber int NOT NULL,
    productCode varchar(15) NOT NULL,
    quantityOrdered int NOT NULL,
    priceEach decimal(10, 2) NOT NULL,
    orderLineNumber SMALLINT NOT NULL,
    primary key (orderNumber, productCode),
    foreign key (orderNumber) references orders (orderNumber),
    foreign key (productCode) references products (productCode)
);

create table payments (
    customerNumber int NOT NULL,
    checkNumber varchar(50) NOT NULL,
    paymentDate date NOT NULL,
    amount decimal(10, 2) NOT NULL,
    primary key (customerNumber, checkNumber),
    foreign key (customerNumber) references customers (customerNumber)
);

INSERT INTO
    productlines
VALUES (
        'Classic Cars',
        'Classic car models from 1950s-1970s era',
        'Classic cars collection including vintage and muscle cars',
        NULL
    ),
    (
        'Motorcycles',
        'Motorcycle models from various eras',
        'Motorcycle collection featuring Harley Davidson, Ducati, etc.',
        NULL
    ),
    (
        'Planes',
        'Aircraft models including commercial and military',
        'Airplane collection from WWII to modern jets',
        NULL
    ),
    (
        'Ships',
        'Ship models from historic to modern vessels',
        'Ship collection including Titanic, cargo ships, etc.',
        NULL
    ),
    (
        'Trains',
        'Train models from steam to bullet trains',
        'Train collection from around the world',
        NULL
    ),
    (
        'Trucks and Buses',
        'Commercial vehicle models',
        'Truck and bus collection from various countries',
        NULL
    ),
    (
        'Vintage Cars',
        'Vintage and classic cars from pre-1950s',
        'Vintage car collection from the early automobile era',
        NULL
    );

INSERT INTO
    products
VALUES (
        'S18_1749',
        '1957 Chevy Bel Air',
        'Classic Cars',
        '1:18',
        'Classic Metal Works',
        'Detailed 1957 Chevrolet Bel Air in red with white roof',
        500,
        45.50,
        89.99
    ),
    (
        'S18_2248',
        '1968 Ford Mustang',
        'Classic Cars',
        '1:18',
        'Muscle Cars Ltd',
        '1968 Ford Mustang Fastback in Highland Green',
        320,
        52.75,
        109.99
    ),
    (
        'S24_1578',
        '1970 Plymouth Hemi Cuda',
        'Classic Cars',
        '1:24',
        'Classic Metal Works',
        '1970 Plymouth Hemi Cuda in Plum Crazy purple',
        180,
        67.30,
        149.99
    ),
    (
        'S18_4600',
        '1969 Dodge Charger',
        'Classic Cars',
        '1:18',
        'Muscle Cars Ltd',
        '1969 Dodge Charger R/T in Orange',
        250,
        58.90,
        129.99
    ),
    (
        'S24_3856',
        '1955 Chevy Bel Air',
        'Classic Cars',
        '1:24',
        'Classic Metal Works',
        '1955 Chevrolet Bel Air in Turquoise',
        400,
        38.25,
        79.99
    ),
    (
        'S18_2432',
        '1965 Shelby Cobra',
        'Classic Cars',
        '1:18',
        'Precision Models',
        '1965 Shelby Cobra 427 in Guardsman Blue',
        150,
        89.50,
        199.99
    ),
    (
        'S32_1374',
        '1971 Ford Mustang Boss 351',
        'Classic Cars',
        '1:32',
        'Muscle Cars Ltd',
        '1971 Ford Mustang Boss 351 in Grabber Green',
        275,
        42.80,
        94.99
    ),
    (
        'S18_3270',
        '1967 Pontiac GTO',
        'Classic Cars',
        '1:18',
        'Classic Metal Works',
        '1967 Pontiac GTO in Red',
        200,
        55.60,
        119.99
    ),
    (
        'S18_2325',
        'Harley Davidson Softail',
        'Motorcycles',
        '1:18',
        'Cycle World Models',
        'Harley Davidson Softail in Black',
        180,
        72.40,
        159.99
    ),
    (
        'S24_2360',
        'Ducati Monster 1200',
        'Motorcycles',
        '1:24',
        'Cycle World Models',
        'Ducati Monster 1200 in Red',
        210,
        45.30,
        99.99
    ),
    (
        'S18_2795',
        'Triumph Bonneville T120',
        'Motorcycles',
        '1:18',
        'Cycle World Models',
        'Triumph Bonneville T120 in Silver',
        95,
        68.90,
        149.99
    ),
    (
        'S32_2206',
        'Kawasaki Ninja ZX-10R',
        'Motorcycles',
        '1:32',
        'Cycle World Models',
        'Kawasaki Ninja ZX-10R in Lime Green',
        340,
        35.60,
        79.99
    ),
    (
        'S18_2433',
        'BMW R1250GS',
        'Motorcycles',
        '1:18',
        'Cycle World Models',
        'BMW R1250GS Adventure in Rallye Red',
        120,
        78.50,
        169.99
    ),
    (
        'S24_2823',
        'Yamaha YZF-R1',
        'Motorcycles',
        '1:24',
        'Cycle World Models',
        'Yamaha YZF-R1 in Blue',
        160,
        42.30,
        89.99
    ),
    (
        'S18_1750',
        'Boeing 747 Jumbo Jet',
        'Planes',
        '1:18',
        'Aero Model Co',
        'Boeing 747-400 in British Airways livery',
        45,
        125.00,
        249.99
    ),
    (
        'S24_3359',
        'P-51 Mustang Fighter',
        'Planes',
        '1:24',
        'Aero Model Co',
        'WWII P-51 Mustang in American Air Force livery',
        75,
        95.40,
        199.99
    ),
    (
        'S18_3320',
        'F-22 Raptor',
        'Planes',
        '1:18',
        'Aero Model Co',
        'F-22 Raptor Stealth Fighter in grey',
        30,
        150.00,
        299.99
    ),
    (
        'S32_2690',
        'Airbus A380',
        'Planes',
        '1:32',
        'Aero Model Co',
        'Airbus A380 in Singapore Airlines livery',
        60,
        110.50,
        229.99
    ),
    (
        'S24_3812',
        'Spitfire Mk IX',
        'Planes',
        '1:24',
        'Aero Model Co',
        'WWII Supermarine Spitfire in RAF livery',
        90,
        85.20,
        179.99
    ),
    (
        'S18_2625',
        'Titanic',
        'Ships',
        '1:18',
        'Maritime Models',
        'RMS Titanic detailed model with lifeboats',
        25,
        220.00,
        449.99
    ),
    (
        'S24_2662',
        'USS Missouri',
        'Ships',
        '1:24',
        'Maritime Models',
        'WWII USS Missouri Battleship',
        35,
        180.50,
        389.99
    ),
    (
        'S18_2972',
        'Queen Mary 2',
        'Ships',
        '1:18',
        'Maritime Models',
        'Queen Mary 2 Cruise Liner',
        20,
        250.00,
        499.99
    ),
    (
        'S32_2956',
        'Container Ship',
        'Ships',
        '1:32',
        'Maritime Models',
        'Modern Container Ship with containers',
        50,
        95.75,
        199.99
    ),
    (
        'S24_3128',
        'Viking Ship',
        'Ships',
        '1:24',
        'Maritime Models',
        'Viking Longship with dragon head',
        40,
        75.30,
        159.99
    ),
    (
        'S18_3135',
        'Steam Locomotive',
        'Trains',
        '1:18',
        'Railway Models',
        '1860s Steam Locomotive with tender',
        30,
        165.00,
        349.99
    ),
    (
        'S24_3240',
        'Bullet Train Shinkansen',
        'Trains',
        '1:24',
        'Railway Models',
        'Japanese Shinkansen N700 series',
        55,
        130.40,
        279.99
    ),
    (
        'S18_3391',
        'Orient Express',
        'Trains',
        '1:18',
        'Railway Models',
        'Orient Express Luxury Train Set',
        15,
        290.00,
        599.99
    ),
    (
        'S32_3409',
        'Diesel Locomotive',
        'Trains',
        '1:32',
        'Railway Models',
        'Modern Diesel Locomotive',
        70,
        85.60,
        179.99
    ),
    (
        'S24_3587',
        'Polar Express',
        'Trains',
        '1:24',
        'Railway Models',
        'Polar Express Christmas Train',
        45,
        98.90,
        209.99
    ),
    (
        'S18_3629',
        'Peterbilt 379 Truck',
        'Trucks and Buses',
        '1:18',
        'Commercial Models',
        'Peterbilt 379 Semi Truck with trailer',
        80,
        145.80,
        299.99
    ),
    (
        'S24_3684',
        'London Double Decker Bus',
        'Trucks and Buses',
        '1:24',
        'Commercial Models',
        'Routemaster London Double Decker Bus',
        65,
        78.30,
        169.99
    ),
    (
        'S18_3772',
        'Ford F-150 Raptor',
        'Trucks and Buses',
        '1:18',
        'Commercial Models',
        'Ford F-150 Raptor pickup truck',
        90,
        55.20,
        119.99
    ),
    (
        'S32_3819',
        'Scania Truck',
        'Trucks and Buses',
        '1:32',
        'Commercial Models',
        'Scania R-series Semi Truck',
        110,
        62.45,
        134.99
    ),
    (
        'S24_3924',
        'School Bus',
        'Trucks and Buses',
        '1:24',
        'Commercial Models',
        'Yellow School Bus',
        75,
        45.80,
        99.99
    ),
    (
        'S18_4068',
        'Fire Truck',
        'Trucks and Buses',
        '1:18',
        'Commercial Models',
        'Fire Truck with aerial ladder',
        40,
        98.60,
        209.99
    ),
    (
        'S18_4137',
        'Model T Ford',
        'Vintage Cars',
        '1:18',
        'Vintage Auto Models',
        '1908 Ford Model T in Black',
        60,
        120.50,
        259.99
    ),
    (
        'S24_4205',
        'Rolls Royce Phantom',
        'Vintage Cars',
        '1:24',
        'Vintage Auto Models',
        '1925 Rolls Royce Phantom in Silver',
        35,
        185.00,
        399.99
    ),
    (
        'S18_4345',
        'Bugatti Type 35',
        'Vintage Cars',
        '1:18',
        'Vintage Auto Models',
        '1924 Bugatti Type 35 Race Car',
        25,
        210.00,
        449.99
    ),
    (
        'S32_4412',
        'Mercedes SSK',
        'Vintage Cars',
        '1:32',
        'Vintage Auto Models',
        '1928 Mercedes SSK Roadster',
        45,
        95.75,
        199.99
    );

INSERT INTO
    offices
VALUES (
        1,
        'San Francisco',
        '+1 650 555 1234',
        '100 Market Street',
        'Suite 300',
        'CA',
        'USA',
        94105,
        'NA'
    ),
    (
        2,
        'New York',
        '+1 212 555 5678',
        '555 5th Avenue',
        'Floor 22',
        'NY',
        'USA',
        10022,
        'NA'
    ),
    (
        3,
        'London',
        '+44 20 7946 0123',
        '25 Old Broad Street',
        NULL,
        NULL,
        'UK',
        'EC2N 1HN',
        'EMEA'
    ),
    (
        4,
        'Paris',
        '+33 1 40 15 4567',
        '8 Rue du Faubourg',
        '2nd Floor',
        NULL,
        'France',
        75008,
        'EMEA'
    ),
    (
        5,
        'Tokyo',
        '+81 3 3546 7890',
        '1-1-2 Marunouchi',
        'Chiyoda-ku',
        NULL,
        'Japan',
        '100-0005',
        'APAC'
    ),
    (
        6,
        'Sydney',
        '+61 2 9333 1234',
        '25 Martin Place',
        'Level 15',
        'NSW',
        'Australia',
        2000,
        'APAC'
    ),
    (
        7,
        'Toronto',
        '+1 416 555 9876',
        '200 Bay Street',
        'Suite 450',
        'ON',
        'Canada',
        'M5J 2J3',
        'NA'
    );

INSERT INTO
    employees
VALUES (
        1001,
        'Murphy',
        'Diane',
        'x1001',
        'diane.murphy@classicmodels.com',
        1,
        NULL,
        'President'
    ),
    (
        1002,
        'Patterson',
        'Mary',
        'x1002',
        'mary.patterson@classicmodels.com',
        1,
        1001,
        'Sales Manager'
    ),
    (
        1003,
        'Smith',
        'James',
        'x1003',
        'james.smith@classicmodels.com',
        2,
        1001,
        'Sales Manager'
    ),
    (
        1004,
        'Johnson',
        'Robert',
        'x1004',
        'robert.johnson@classicmodels.com',
        3,
        1001,
        'Sales Manager'
    ),
    (
        1005,
        'Brown',
        'Lisa',
        'x1005',
        'lisa.brown@classicmodels.com',
        4,
        1001,
        'Sales Manager'
    ),
    (
        1006,
        'Lee',
        'David',
        'x1006',
        'david.lee@classicmodels.com',
        5,
        1001,
        'Sales Manager'
    ),
    (
        1007,
        'Wilson',
        'Sarah',
        'x1007',
        'sarah.wilson@classicmodels.com',
        6,
        1001,
        'Sales Manager'
    ),
    (
        1008,
        'Garcia',
        'Michael',
        'x1008',
        'michael.garcia@classicmodels.com',
        1,
        1002,
        'Sales Rep'
    ),
    (
        1009,
        'Martinez',
        'John',
        'x1009',
        'john.martinez@classicmodels.com',
        1,
        1002,
        'Sales Rep'
    ),
    (
        1010,
        'Davis',
        'Emily',
        'x1010',
        'emily.davis@classicmodels.com',
        1,
        1002,
        'Sales Rep'
    ),
    (
        1011,
        'Rodriguez',
        'Christopher',
        'x1011',
        'chris.rodriguez@classicmodels.com',
        2,
        1003,
        'Sales Rep'
    ),
    (
        1012,
        'Miller',
        'Karen',
        'x1012',
        'karen.miller@classicmodels.com',
        2,
        1003,
        'Sales Rep'
    ),
    (
        1013,
        'Jones',
        'Matthew',
        'x1013',
        'matthew.jones@classicmodels.com',
        3,
        1004,
        'Sales Rep'
    ),
    (
        1014,
        'Taylor',
        'Emma',
        'x1014',
        'emma.taylor@classicmodels.com',
        3,
        1004,
        'Sales Rep'
    ),
    (
        1015,
        'Williams',
        'Daniel',
        'x1015',
        'daniel.williams@classicmodels.com',
        3,
        1004,
        'Sales Rep'
    ),
    (
        1016,
        'Martin',
        'Sophie',
        'x1016',
        'sophie.martin@classicmodels.com',
        4,
        1005,
        'Sales Rep'
    ),
    (
        1017,
        'Bernard',
        'Jean',
        'x1017',
        'jean.bernard@classicmodels.com',
        4,
        1005,
        'Sales Rep'
    ),
    (
        1018,
        'Tanaka',
        'Yuki',
        'x1018',
        'yuki.tanaka@classicmodels.com',
        5,
        1006,
        'Sales Rep'
    ),
    (
        1019,
        'Sato',
        'Kenji',
        'x1019',
        'kenji.sato@classicmodels.com',
        5,
        1006,
        'Sales Rep'
    ),
    (
        1020,
        'Anderson',
        'Kate',
        'x1020',
        'kate.anderson@classicmodels.com',
        6,
        1007,
        'Sales Rep'
    ),
    (
        1021,
        'Thompson',
        'Peter',
        'x1021',
        'peter.thompson@classicmodels.com',
        6,
        1007,
        'Sales Rep'
    ),
    (
        1022,
        'White',
        'Laura',
        'x1022',
        'laura.white@classicmodels.com',
        1,
        1002,
        'Customer Support'
    ),
    (
        1023,
        'Clark',
        'Mark',
        'x1023',
        'mark.clark@classicmodels.com',
        2,
        1003,
        'Customer Support'
    );

INSERT INTO
    customers
VALUES (
        101,
        'Classic Auto Parts',
        'Smith',
        'John',
        '+1 312 555 0101',
        '123 Main Street',
        NULL,
        'Chicago',
        'IL',
        60601,
        'USA',
        1008,
        50000
    ),
    (
        102,
        'Vintage Car Collectors',
        'Johnson',
        'Robert',
        '+1 213 555 0202',
        '456 Sunset Blvd',
        'Suite 200',
        'Los Angeles',
        'CA',
        90210,
        'USA',
        1008,
        75000
    ),
    (
        103,
        'Scale Model Depot',
        'Williams',
        'Michael',
        '+1 713 555 0303',
        '789 Industrial Drive',
        NULL,
        'Houston',
        'TX',
        77001,
        'USA',
        1009,
        25000
    ),
    (
        104,
        'Collector\'s Corner',
        'Brown',
        'David',
        '+1 305 555 0404',
        '101 Ocean Drive',
        'Unit 5',
        'Miami',
        'FL',
        33101,
        'USA',
        1009,
        60000
    ),
    (
        105,
        'Model World',
        'Davis',
        'James',
        '+1 214 555 0505',
        '202 Commerce Street',
        NULL,
        'Dallas',
        'TX',
        75201,
        'USA',
        1010,
        30000
    ),
    (
        106,
        'Toy R Us',
        'Miller',
        'Patricia',
        '+1 416 555 0606',
        '303 Queen Street',
        NULL,
        'Toronto',
        'ON',
        'M5V 2A1',
        'Canada',
        1007,
        45000
    ),
    (
        107,
        'Hobby Central',
        'Wilson',
        'Linda',
        '+1 514 555 0707',
        '404 St. Catherine',
        'Floor 2',
        'Montreal',
        'QC',
        'H3B 1A1',
        'Canada',
        1007,
        35000
    ),
    (
        108,
        'British Model Shop',
        'Taylor',
        'Richard',
        '+44 20 7946 0808',
        '10 Oxford Street',
        NULL,
        'London',
        NULL,
        'W1D 1AN',
        'UK',
        1013,
        55000
    ),
    (
        109,
        'Classic Cars UK',
        'Anderson',
        'Sarah',
        '+44 161 234 0909',
        '5 Market Street',
        NULL,
        'Manchester',
        NULL,
        'M1 1AD',
        'UK',
        1014,
        40000
    ),
    (
        110,
        'Railway Models Ltd',
        'Thomas',
        'Peter',
        '+44 121 345 1010',
        '15 Station Road',
        NULL,
        'Birmingham',
        NULL,
        'B1 1BD',
        'UK',
        1013,
        25000
    ),
    (
        111,
        'Auto Models Paris',
        'Martinez',
        'Maria',
        '+33 1 40 15 1111',
        '12 Rue de Rivoli',
        NULL,
        'Paris',
        NULL,
        75001,
        'France',
        1016,
        50000
    ),
    (
        112,
        'Modelle Berlin',
        'Schmidt',
        'Hans',
        '+49 30 2345 1212',
        '24 Alexanderplatz',
        NULL,
        'Berlin',
        NULL,
        10178,
        'Germany',
        1016,
        60000
    ),
    (
        113,
        'Modelli Milano',
        'Rossi',
        'Marco',
        '+39 02 1234 1313',
        '8 Via Montenapoleone',
        NULL,
        'Milan',
        NULL,
        20121,
        'Italy',
        1017,
        45000
    ),
    (
        114,
        'Modelos Madrid',
        'Garcia',
        'Antonio',
        '+34 91 4567 1414',
        '10 Calle Mayor',
        NULL,
        'Madrid',
        NULL,
        28013,
        'Spain',
        1017,
        30000
    ),
    (
        115,
        'Tokyo Model Center',
        'Yamamoto',
        'Hiroshi',
        '+81 3 3567 1515',
        '5-2-1 Ginza',
        'Chuo-ku',
        'Tokyo',
        NULL,
        '104-0061',
        'Japan',
        1018,
        70000
    ),
    (
        116,
        'Hong Kong Models',
        'Chen',
        'Wei',
        '+852 2525 1616',
        '15 Des Voeux Road',
        NULL,
        'Central',
        NULL,
        NULL,
        'Hong Kong',
        1018,
        55000
    ),
    (
        117,
        'Sydney Model Co',
        'O\'Brien',
        'Patrick',
        '+61 2 9333 1717',
        '25 George Street',
        NULL,
        'Sydney',
        'NSW',
        2000,
        'Australia',
        1020,
        40000
    ),
    (
        118,
        'Melbourne Hobbies',
        'Nguyen',
        'Tom',
        '+61 3 9876 1818',
        '8 Collins Street',
        NULL,
        'Melbourne',
        'VIC',
        3000,
        'Australia',
        1021,
        35000
    ),
    (
        119,
        'Auto Model World',
        'Jackson',
        'Kevin',
        '+1 404 555 1919',
        '1 Peachtree Center',
        NULL,
        'Atlanta',
        'GA',
        30303,
        'USA',
        1010,
        30000
    ),
    (
        120,
        'Classic Motor City',
        'Harris',
        'Daniel',
        '+1 313 555 2020',
        '200 Woodward Avenue',
        NULL,
        'Detroit',
        'MI',
        48201,
        'USA',
        1008,
        65000
    ),
    (
        121,
        'Scale Modelers Inc',
        'Martin',
        'Nancy',
        '+1 503 555 2121',
        '5 Pioneer Square',
        NULL,
        'Portland',
        'OR',
        97204,
        'USA',
        1009,
        28000
    ),
    (
        122,
        'Vintage Toys',
        'Thompson',
        'Steve',
        '+1 602 555 2222',
        '10 Camelback Road',
        NULL,
        'Phoenix',
        'AZ',
        85001,
        'USA',
        1010,
        22000
    ),
    (
        123,
        'Miniature World',
        'Garcia',
        'Robert',
        '+1 505 555 2323',
        '15 Old Town Plaza',
        NULL,
        'Albuquerque',
        'NM',
        87101,
        'USA',
        1008,
        25000
    ),
    (
        124,
        'Holland Model Shop',
        'Van der Meer',
        'Jan',
        '+31 20 555 2424',
        '12 Dam Square',
        NULL,
        'Amsterdam',
        NULL,
        1012,
        'Netherlands',
        1014,
        35000
    ),
    (
        125,
        'Swiss Collectables',
        'Muller',
        'Klaus',
        '+41 44 555 2525',
        '8 Bahnhofstrasse',
        NULL,
        'Zurich',
        NULL,
        8001,
        'Switzerland',
        1015,
        50000
    ),
    (
        126,
        'Belgian Models',
        'Dubois',
        'Jean',
        '+32 2 555 2626',
        '25 Grand Place',
        NULL,
        'Brussels',
        NULL,
        1000,
        'Belgium',
        1014,
        28000
    ),
    (
        127,
        'Singapore Model Co',
        'Lim',
        'Swee',
        '+65 6555 2727',
        '10 Orchard Road',
        NULL,
        'Singapore',
        NULL,
        238874,
        'Singapore',
        1019,
        40000
    ),
    (
        128,
        'Seoul Models',
        'Kim',
        'Soo',
        '+82 2 555 2828',
        '50 Myeongdong',
        NULL,
        'Seoul',
        NULL,
        '04536',
        'South Korea',
        1018,
        35000
    ),
    (
        129,
        'Mumbai Collectors',
        'Patel',
        'Arjun',
        '+91 22 555 2929',
        '15 Colaba Causeway',
        NULL,
        'Mumbai',
        NULL,
        400005,
        'India',
        1019,
        30000
    ),
    (
        130,
        'Vancouver Models',
        'Wong',
        'Ming',
        '+1 604 555 3030',
        '100 Robson Street',
        NULL,
        'Vancouver',
        'BC',
        'V6B 2A1',
        'Canada',
        1007,
        30000
    ),
    (
        131,
        'Edinburgh Collectables',
        'MacDonald',
        'Fiona',
        '+44 131 555 3131',
        '8 Royal Mile',
        NULL,
        'Edinburgh',
        NULL,
        'EH1 1PB',
        'UK',
        1015,
        32000
    ),
    (
        132,
        'Classic Auto Inc',
        'Roberts',
        'Tom',
        '+1 858 555 3232',
        '500 La Jolla Blvd',
        NULL,
        'San Diego',
        'CA',
        92037,
        'USA',
        1009,
        45000
    ),
    (
        133,
        'International Models',
        'Kim',
        'Yuna',
        '+1 831 555 3333',
        '100 Cannery Row',
        NULL,
        'Monterey',
        'CA',
        93940,
        'USA',
        1008,
        28000
    ),
    (
        134,
        'Collectible Cars',
        'Lee',
        'Jason',
        '+1 408 555 3434',
        '25 Castro Street',
        NULL,
        'Mountain View',
        'CA',
        94041,
        'USA',
        1010,
        50000
    ),
    (
        135,
        'Hobby World',
        'Tan',
        'Kenny',
        '+65 6222 3535',
        '20 Chinatown Point',
        NULL,
        'Singapore',
        NULL,
        '059122',
        'Singapore',
        1019,
        25000
    );

INSERT INTO
    orders
VALUES (
        2001,
        '2026-01-15',
        '2026-01-22',
        '2026-01-20',
        'Shipped',
        NULL,
        101
    ),
    (
        2002,
        '2026-01-18',
        '2026-01-25',
        '2026-01-24',
        'Shipped',
        'Express shipping requested',
        102
    ),
    (
        2003,
        '2026-01-20',
        '2026-01-27',
        '2026-01-26',
        'Shipped',
        NULL,
        103
    ),
    (
        2004,
        '2026-01-22',
        '2026-01-29',
        '2026-01-28',
        'Shipped',
        NULL,
        104
    ),
    (
        2005,
        '2026-01-25',
        '2026-02-01',
        '2026-01-30',
        'Shipped',
        'Gift wrapping requested',
        105
    ),
    (
        2006,
        '2026-01-28',
        '2026-02-04',
        '2026-02-02',
        'Shipped',
        NULL,
        106
    ),
    (
        2007,
        '2026-02-01',
        '2026-02-08',
        '2026-02-06',
        'Shipped',
        NULL,
        108
    ),
    (
        2008,
        '2026-02-03',
        '2026-02-10',
        '2026-02-09',
        'Shipped',
        NULL,
        111
    ),
    (
        2009,
        '2026-02-05',
        '2026-02-12',
        NULL,
        'In Process',
        'Customer requested white glove delivery',
        115
    ),
    (
        2010,
        '2026-02-07',
        '2026-02-14',
        NULL,
        'In Process',
        NULL,
        119
    ),
    (
        2011,
        '2026-02-09',
        '2026-02-16',
        NULL,
        'In Process',
        'Need to confirm address',
        120
    ),
    (
        2012,
        '2026-02-10',
        '2026-02-17',
        NULL,
        'On Hold',
        'Payment verification pending',
        125
    ),
    (
        2013,
        '2026-02-11',
        '2026-02-18',
        NULL,
        'On Hold',
        'Customer requested hold',
        127
    ),
    (
        2014,
        '2026-02-12',
        '2026-02-19',
        '2026-02-14',
        'Cancelled',
        'Customer cancelled order',
        112
    ),
    (
        2015,
        '2026-02-13',
        '2026-02-20',
        '2026-02-15',
        'Resolved',
        'Payment issue resolved',
        130
    ),
    (
        2016,
        '2026-02-14',
        '2026-02-21',
        '2026-02-18',
        'Disputed',
        'Customer claims missing item',
        105
    ),
    (
        2017,
        '2025-12-01',
        '2025-12-08',
        '2025-12-06',
        'Shipped',
        'Holiday order',
        101
    ),
    (
        2018,
        '2025-12-05',
        '2025-12-12',
        '2025-12-10',
        'Shipped',
        NULL,
        108
    ),
    (
        2019,
        '2025-12-10',
        '2025-12-17',
        '2025-12-15',
        'Shipped',
        NULL,
        111
    ),
    (
        2020,
        '2025-12-15',
        '2025-12-22',
        '2025-12-20',
        'Shipped',
        NULL,
        115
    ),
    (
        2021,
        '2026-02-15',
        '2026-02-22',
        NULL,
        'In Process',
        'Urgent order - please expedite',
        135
    ),
    (
        2022,
        '2026-02-16',
        '2026-02-23',
        NULL,
        'In Process',
        NULL,
        108
    ),
    (
        2023,
        '2026-02-17',
        '2026-02-24',
        NULL,
        'Shipped',
        NULL,
        106
    ),
    (
        2024,
        '2026-02-18',
        '2026-02-25',
        NULL,
        'In Process',
        'Need gift wrapping',
        101
    ),
    (
        2025,
        '2026-02-19',
        '2026-02-26',
        NULL,
        'Shipped',
        NULL,
        118
    );

INSERT INTO
    orderdetails
VALUES (2001, 'S18_1749', 2, 89.99, 1),
    (
        2001,
        'S18_2248',
        1,
        109.99,
        2
    ),
    (
        2001,
        'S24_1578',
        1,
        149.99,
        3
    ),
    (
        2002,
        'S18_2325',
        3,
        159.99,
        1
    ),
    (2002, 'S24_2360', 2, 99.99, 2),
    (2002, 'S18_1749', 1, 89.99, 3),
    (
        2002,
        'S18_4600',
        1,
        129.99,
        4
    ),
    (
        2003,
        'S18_2625',
        2,
        449.99,
        1
    ),
    (
        2003,
        'S24_2662',
        1,
        389.99,
        2
    ),
    (
        2003,
        'S18_2972',
        1,
        499.99,
        3
    ),
    (
        2004,
        'S18_3135',
        1,
        349.99,
        1
    ),
    (
        2004,
        'S24_3240',
        2,
        279.99,
        2
    ),
    (
        2004,
        'S18_3391',
        1,
        599.99,
        3
    ),
    (
        2005,
        'S18_3629',
        2,
        299.99,
        1
    ),
    (
        2005,
        'S24_3684',
        1,
        169.99,
        2
    ),
    (
        2005,
        'S18_3772',
        2,
        119.99,
        3
    ),
    (
        2006,
        'S18_4137',
        1,
        259.99,
        1
    ),
    (
        2006,
        'S24_4205',
        2,
        399.99,
        2
    ),
    (
        2006,
        'S18_4345',
        1,
        449.99,
        3
    ),
    (2007, 'S18_1749', 3, 89.99, 1),
    (
        2007,
        'S18_2248',
        2,
        109.99,
        2
    ),
    (
        2007,
        'S18_2325',
        1,
        159.99,
        3
    ),
    (
        2007,
        'S24_1578',
        1,
        149.99,
        4
    ),
    (
        2008,
        'S18_2625',
        1,
        449.99,
        1
    ),
    (
        2008,
        'S18_2972',
        1,
        499.99,
        2
    ),
    (
        2008,
        'S18_3135',
        1,
        349.99,
        3
    ),
    (
        2009,
        'S18_3391',
        1,
        599.99,
        1
    ),
    (
        2009,
        'S18_3629',
        2,
        299.99,
        2
    ),
    (
        2009,
        'S18_4137',
        1,
        259.99,
        3
    ),
    (
        2010,
        'S18_4600',
        2,
        129.99,
        1
    ),
    (2010, 'S24_3856', 3, 79.99, 2),
    (
        2010,
        'S18_2433',
        1,
        199.99,
        3
    ),
    (
        2011,
        'S18_3320',
        1,
        299.99,
        1
    ),
    (
        2011,
        'S24_3359',
        2,
        199.99,
        2
    ),
    (2011, 'S18_1749', 1, 89.99, 3),
    (
        2012,
        'S18_3772',
        2,
        119.99,
        1
    ),
    (
        2012,
        'S24_3684',
        1,
        169.99,
        2
    ),
    (
        2012,
        'S18_4068',
        1,
        209.99,
        3
    ),
    (
        2013,
        'S24_4205',
        2,
        399.99,
        1
    ),
    (
        2013,
        'S18_4345',
        1,
        449.99,
        2
    ),
    (
        2013,
        'S32_4412',
        2,
        199.99,
        3
    ),
    (
        2014,
        'S18_2248',
        1,
        109.99,
        1
    ),
    (
        2014,
        'S24_1578',
        1,
        149.99,
        2
    ),
    (
        2015,
        'S18_2325',
        1,
        159.99,
        1
    ),
    (2015, 'S24_2360', 2, 99.99, 2),
    (
        2016,
        'S18_2625',
        1,
        449.99,
        1
    ),
    (
        2016,
        'S24_2662',
        1,
        389.99,
        2
    ),
    (
        2016,
        'S18_2972',
        1,
        499.99,
        3
    ),
    (
        2017,
        'S18_3135',
        1,
        349.99,
        1
    ),
    (2017, 'S18_1749', 2, 89.99, 2),
    (
        2017,
        'S18_4600',
        2,
        129.99,
        3
    ),
    (
        2018,
        'S18_3320',
        1,
        299.99,
        1
    ),
    (
        2018,
        'S24_3812',
        2,
        179.99,
        2
    ),
    (
        2019,
        'S18_3629',
        2,
        299.99,
        1
    ),
    (
        2019,
        'S18_3772',
        1,
        119.99,
        2
    ),
    (
        2019,
        'S24_3684',
        1,
        169.99,
        3
    ),
    (
        2020,
        'S18_4137',
        1,
        259.99,
        1
    ),
    (
        2020,
        'S32_4412',
        1,
        199.99,
        2
    ),
    (
        2021,
        'S18_2248',
        2,
        109.99,
        1
    ),
    (
        2021,
        'S24_1578',
        1,
        149.99,
        2
    ),
    (
        2021,
        'S18_2325',
        2,
        159.99,
        3
    ),
    (2021, 'S18_1749', 1, 89.99, 4),
    (
        2022,
        'S18_2625',
        1,
        449.99,
        1
    ),
    (
        2022,
        'S18_2972',
        1,
        499.99,
        2
    ),
    (
        2022,
        'S18_3391',
        1,
        599.99,
        3
    ),
    (
        2023,
        'S18_4137',
        2,
        259.99,
        1
    ),
    (
        2023,
        'S18_4345',
        1,
        449.99,
        2
    ),
    (
        2024,
        'S18_3772',
        1,
        119.99,
        1
    ),
    (
        2024,
        'S18_4068',
        1,
        209.99,
        2
    ),
    (
        2024,
        'S24_3684',
        1,
        169.99,
        3
    ),
    (2025, 'S18_1749', 2, 89.99, 1),
    (
        2025,
        'S18_2248',
        1,
        109.99,
        2
    ),
    (
        2025,
        'S24_1578',
        1,
        149.99,
        3
    ),
    (
        2025,
        'S18_4600',
        1,
        129.99,
        4
    );

INSERT INTO
    payments
VALUES (
        101,
        'CHK2026001',
        '2026-01-20',
        459.97
    ),
    (
        101,
        'CHK2026002',
        '2026-02-01',
        300.00
    ),
    (
        102,
        'CHK2026003',
        '2026-01-25',
        749.96
    ),
    (
        103,
        'CHK2026004',
        '2026-01-28',
        1389.97
    ),
    (
        104,
        'CHK2026005',
        '2026-01-29',
        1209.97
    ),
    (
        105,
        'CHK2026006',
        '2026-01-31',
        939.96
    ),
    (
        105,
        'CHK2026007',
        '2026-02-05',
        500.00
    ),
    (
        106,
        'CHK2026008',
        '2026-02-02',
        1209.97
    ),
    (
        108,
        'CHK2026009',
        '2026-02-05',
        599.96
    ),
    (
        108,
        'CHK2026010',
        '2026-02-10',
        250.00
    ),
    (
        111,
        'CHK2026011',
        '2026-02-07',
        1299.97
    ),
    (
        115,
        'CHK2026012',
        '2026-02-08',
        1159.97
    ),
    (
        119,
        'CHK2026013',
        '2026-02-09',
        499.97
    ),
    (
        120,
        'CHK2026014',
        '2026-02-10',
        619.96
    ),
    (
        125,
        'CHK2026015',
        '2026-02-11',
        409.97
    ),
    (
        127,
        'CHK2026016',
        '2026-02-12',
        999.97
    ),
    (
        130,
        'CHK2026017',
        '2026-02-13',
        659.97
    ),
    (
        135,
        'CHK2026018',
        '2026-02-14',
        699.96
    ),
    (
        101,
        'CHK2026019',
        '2026-02-15',
        400.00
    ),
    (
        102,
        'CHK2026020',
        '2026-02-16',
        250.00
    ),
    (
        108,
        'CHK2026021',
        '2026-02-17',
        1349.97
    ),
    (
        115,
        'CHK2026022',
        '2026-02-18',
        1159.97
    ),
    (
        106,
        'CHK2026023',
        '2026-02-19',
        500.00
    ),
    (
        118,
        'CHK2026024',
        '2026-02-20',
        350.00
    ),
    (
        121,
        'CHK2026025',
        '2026-02-21',
        280.00
    ),
    (
        124,
        'CHK2026026',
        '2026-02-22',
        550.00
    ),
    (
        128,
        'CHK2026027',
        '2026-02-23',
        450.00
    ),
    (
        131,
        'CHK2026028',
        '2026-02-24',
        320.00
    ),
    (
        133,
        'CHK2026029',
        '2026-02-25',
        280.00
    ),
    (
        134,
        'CHK2026030',
        '2026-02-26',
        500.00
    );

select * from productlines;

select * from products;

select * from offices;

select * from employees;

select * from customers;

select * from orders;

select * from orderdetails;

select * from payments;
-- DROP DATABASE sales_management_task;