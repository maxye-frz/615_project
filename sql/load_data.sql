# Things might need change before use:
# 1. Neighborhood zipcode
# 2. path to the data when loading
# use mysql> show global variables like 'local_infile'; to check if local_infile is disabled;
# enable it with mysql> set global local_infile=true;

DROP DATABASE IF EXISTS final_project;

CREATE DATABASE final_project;

USE final_project; 

-- drop and create tables:

DROP TABLE IF EXISTS Neighbourhood;
CREATE TABLE Neighbourhood(
    name                VARCHAR(25) NOT NULL,
    city                VARCHAR(25) NOT NULL,
    state               VARCHAR(25) NOT NULL,
    country             VARCHAR(25) NOT NULL,
    PRIMARY KEY (name),
    UNIQUE (name, city, state, country)
);


DROP TABLE IF EXISTS Host;
CREATE TABLE Host(
    host_id INT NOT NULL, 
    host_url TEXT NOT NULL, 
    host_name TEXT NOT NULL, 
    host_since DATE NOT NULL, 
    host_location TEXT NOT NULL,
    host_about TEXT, 
    host_response_time TEXT, 
    host_response_rate INT, 
    host_acceptance_rate INT, 
    host_is_superhost VARCHAR(1) NOT NULL, 
    host_thumbnail_url TEXT NOT NULL, 
    host_picture_url TEXT NOT NULL, 
    host_neighbourhood TEXT NOT NULL, 
    host_listings_count INT NOT NULL, 
    host_total_listings_count INT NOT NULL, 
    host_verifications TEXT NOT NULL, 
    host_has_profile_pic VARCHAR(1) NOT NULL, 
    host_identity_verified VARCHAR(2) NOT NULL,
    PRIMARY KEY (host_id)
);


DROP TABLE IF EXISTS Listing;
CREATE TABLE Listing(
    listing_id INT NOT NULL,
    listing_url TEXT NOT NULL, 
    name TEXT NOT NULL, 
    description TEXT NOT NULL, 
    neighborhood_overview TEXT NOT NULL, 
    picture_url TEXT NOT NULL, 
    host_id INT NOT NULL, 
    neighbourhood VARCHAR(100), 
    neighbourhood_cleansed VARCHAR(30) NOT NULL, -- Neighborhood.id? 
    latitude FLOAT NOT NULL, 
    longitude FLOAT NOT NULL, 
    property_type VARCHAR(100) NOT NULL, 
    room_type VARCHAR(20) NOT NULL, 
    accommodates INT NOT NULL, 
    bathrooms_text VARCHAR(20) NOT NULL, 
    bedrooms INT, 
    beds INT NOT NULL, 
    amenities TEXT NOT NULL, 
    price DECIMAL(8, 2) NOT NULL, 
    minimum_nights INT NOT NULL, 
    maximum_nights INT NOT NULL, 
    availability_365 INT NOT NULL, 
    number_of_reviews INT NOT NULL, 
    first_review DATE, 
    last_review DATE, 
    review_scores_rating INT, 
    review_scores_accuracy INT, 
    review_scores_cleanliness INT, 
    review_scores_checkin INT, 
    review_scores_communication INT, 
    review_scores_location INT, 
    review_scores_value INT, 
    instant_bookable VARCHAR(1) NOT NULL, 
    calculated_host_listings_count INT NOT NULL, 
    calculated_host_listings_count_entire_homes INT NOT NULL, 
    calculated_host_listings_count_private_rooms INT NOT NULL,
    calculated_host_listings_count_shared_rooms INT NOT NULL, 
    reviews_per_month DECIMAL(3, 2) NOT NULL,
    PRIMARY KEY (listing_id),
    FOREIGN KEY (host_id) REFERENCES Host(host_id),
    FOREIGN KEY (neighbourhood_cleansed) REFERENCES Neighbourhood(name)
);


DROP TABLE IF EXISTS Reviewer;
CREATE TABLE Reviewer(
    reviewer_id INT NOT NULL,
    reviewer_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (reviewer_id)
);


DROP TABLE IF EXISTS Review;
CREATE TABLE Review(
    review_id INT NOT NULL,
    listing_id INT NOT NULL,
    review_date DATE NOT NULL,
    reviewer_id INT NOT NULL,
    comments TEXT,
    sentiment_score INT,
    PRIMARY KEY (review_id),
    FOREIGN KEY (listing_id) REFERENCES Listing(listing_id),
    FOREIGN KEY (reviewer_id) REFERENCES Reviewer(reviewer_id)
);


DROP TABLE IF EXISTS Covid;
CREATE TABLE Covid(
    neighborhood varchar(50) NOT NULL,
    resident_population INTEGER DEFAULT 0 NOT NULL,
    cumulative_cases INTEGER,
    new_cases INTEGER,
    PRIMARY KEY (neighborhood)
);

INSERT INTO Covid VALUES 
    ('Bayview Hunters Point', 37394, 1962, 352),
    ('Tenderloin', 29588, 1234, 191),
    ('Mission', 59639, 2274, 456),
    ('Visitacion Valley', 19005, 692, 154),
    ('Excelsior', 40701, 1350, 292),
    ('Outer Mission', 24853, 736, 152),
    ('Portola', 16563, 473, 110),
    ('Japantown', 3532, 97, 12),
    ('South of Market', 21771, 522, 104),
    ('Bernal Heights', 25858, 546, 135),
    ('Oceanview/Merced/Ingleside', 58517, 545, 121),
    ('Western Addition', 22638, 432, 92),
    ('Mission Bay', 12180, 228, 63),
    ('Treasure Island', 3064, 56, 14),
    ('Potrero Hill', 14209, 252, 54),
    ('Hayes Valley', 19678, 304, 76),
    ('Financial District/South Beach', 19458, 300, 90),
    ('Marina', 25331, 371, 145),
    ('Presidio', 4119, 56, 15),
    ('Pacific Heights', 24462, 317, 84),
    ('Castro/Upper Market', 22284, 287, 102),
    ('Russian Hill', 17830, 227, 72),
    ('Nob Hill', 26579, 319, 99),
    ('North Beach', 11636, 137, 37),
    ('Presidio Heights', 10699, 123, 55),
    ('Twin Peaks', 8019, 87, 22),
    ('Noe Valley', 23507, 239, 79),
    ('Lakeshore', 14643, 141, 27),
    ('Inner Richmond', 22220, 203, 64),
    ('West of Twin Peaks', 39496, 355, 123),
    ('Lone Mountain/USF', 17831, 153, 55),
    ('Glen Park', 8641, 73, 19),
    ('Outer Richmond', 45891, 374, 113),
    ('Inner Sunset', 29307, 217, 58),
    ('Sunset/Parkside', 82410, 583, 213),
    ('Haight Ashbury', 18524, 130, 41),
    ('Chinatown', 14737, 102, 25),
    ('Golden Gate Park', 66, NULL, NULL),
    ('Lincoln Park', 305, NULL, NULL),
    ('McLaren Park', 669, NULL, NULL),
    ('Seacliff', 2490, 12, 3);

SET SQL_SAFE_UPDATES = 0;

ALTER TABLE Covid 
ADD COLUMN Rate_of_cases_per_10000 DECIMAL(6, 2)
AFTER cumulative_cases;

UPDATE Covid
SET Rate_of_cases_per_10000 = cumulative_cases/(resident_population/10000);

ALTER TABLE Covid
ADD COLUMN Rate_of_new_cases_per_10000 DECIMAL(6, 2)
AFTER new_cases;

UPDATE Covid 
SET Rate_of_new_cases_per_10000 = new_cases/(resident_population/10000);


DROP TABLE IF EXISTS Zipcode;
CREATE TABLE Zipcode(
    pairID INT NOT NULL AUTO_INCREMENT,
    airbnb_neighbourhood VARCHAR(30) NOT NULL,
    covid_neighborhood VARCHAR(50) NOT NULL,
    zipcode INT NOT NULL,
    PRIMARY KEY (pairID)
);


DROP TABLE IF EXISTS Park;
CREATE TABLE Park(
    parkID INT NOT NULL,
    PSA TEXT,
    park TEXT,
    FQ TEXT,
    score DECIMAL(4, 3) NOT NULL,
    facility_type TEXT,
    facility_name TEXT NOT NULL,
    address TEXT NOT NULL,
    state VARCHAR(2) DEFAULT 'CA',
    zipcode INT,
    floor_count INT,
    square_feet DECIMAL(12, 2),
    perimeter_length DECIMAL(8, 2),
    acres DECIMAL(5, 4),
    longitude FLOAT NOT NULL,
    latitude FLOAT NOT NULL,
    PRIMARY KEY (parkID)
);

-- load data from '/data'

LOAD DATA LOCAL INFILE 'data/airbnb_covid_neighborhood.csv' 
INTO TABLE Zipcode
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(airbnb_neighbourhood, covid_neighborhood, zipcode);


LOAD DATA LOCAL INFILE 'data/neighbourhoods.csv' 
INTO TABLE Neighbourhood
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(name, city, state, country);


LOAD DATA LOCAL INFILE 'data/hosts.csv' 
IGNORE
INTO TABLE Host 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(host_id, host_url, host_name, @host_since, host_location, host_about, host_response_time, 
    @host_response_rate, @host_acceptance_rate, host_is_superhost,  host_thumbnail_url, host_picture_url,
    host_neighbourhood, host_listings_count, host_total_listings_count, host_verifications, host_has_profile_pic, 
    host_identity_verified)
SET host_since = STR_TO_DATE(@host_since, '%m/%d/%Y'),
    host_response_rate = TRIM(TRAILING '%' FROM NULLIF(@host_response_rate, '')),
    host_acceptance_rate = TRIM(TRAILING '%' FROM NULLIF(@host_acceptance_rate, ''));


LOAD DATA LOCAL INFILE 'data/listings.csv' 
IGNORE
INTO TABLE Listing 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(listing_id,listing_url,name,description,neighborhood_overview,picture_url,host_id,neighbourhood,neighbourhood_cleansed,
    latitude,longitude,property_type,room_type,accommodates,bathrooms_text,bedrooms,beds,amenities,@price,
    minimum_nights,maximum_nights,availability_365,number_of_reviews,@first_review,@last_review,
    review_scores_rating,review_scores_accuracy,review_scores_cleanliness,review_scores_checkin,review_scores_communication,
    review_scores_location,review_scores_value,instant_bookable,calculated_host_listings_count,
    calculated_host_listings_count_entire_homes,calculated_host_listings_count_private_rooms,
    calculated_host_listings_count_shared_rooms,reviews_per_month)
SET price = TRIM(LEADING '$' FROM NULLIF(@price, '')),
    first_review = STR_TO_DATE(@first_review, '%m/%d/%Y'),
    last_review = STR_TO_DATE(@last_review, '%m/%d/%Y');


LOAD DATA LOCAL INFILE 'data/reviewers.csv' 
IGNORE
INTO TABLE Reviewer
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(reviewer_id, reviewer_name);


LOAD DATA LOCAL INFILE 'data/reviews.csv' 
IGNORE
INTO TABLE Review
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(listing_id, review_id, @review_date, reviewer_id, comments)
SET review_date = STR_TO_DATE(@review_date, '%m/%d/%Y');


LOAD DATA LOCAL INFILE 'data/SF_Park_Scores.csv' 
INTO TABLE Park
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(parkID, PSA, park, FQ, score, facility_type, facility_name, address, state, zipcode, floor_count, square_feet, perimeter_length, acres, longitude, latitude);

-- # Replace neighbourhood_cleanse by zipcode(foreign key) in Listing
-- ALTER TABLE Listing
-- ADD zipcode INT;

-- ALTER TABLE Listing
-- ADD CONSTRAINT fk_neighborhood FOREIGN KEY (zipcode) REFERENCES Neighbourhood(zipcode);

-- UPDATE Listing
-- INNER JOIN Neighbourhood ON Listing.neighbourhood_cleansed = Neighbourhood.name
-- SET Listing.zipcode = Neighbourhood.zipcode;

-- ALTER TABLE Listing
-- DROP COLUMN neighbourhood_cleansed;


