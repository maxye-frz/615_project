# Things might need change before use:
# 1. Neighborhood zipcode
# 2. path to the data when loading 

DROP TABLE IF EXISTS Neighbourhood;
CREATE TABLE Neighbourhood(
    zipcode             INT NOT NULL AUTO_INCREMENT,
    name                VARCHAR(25) NOT NULL,
    city                VARCHAR(25) NOT NULL,
    state               VARCHAR(25) NOT NULL,
    country             VARCHAR(25) NOT NULL,
    covid_case          INT,
    PRIMARY KEY (zipcode),
    UNIQUE (name, city, state, country)
);

DROP TABLE IF EXISTS Host;
CREATE TABLE Host(
    host_id INT NOT NULL, 
    host_url VARCHAR(200) NOT NULL, 
    host_name VARCHAR(20) NOT NULL, 
    host_since DATE NOT NULL, 
    host_location VARCHAR(50) NOT NULL, -- Neighborhood.id?
    host_about VARCHAR(2000)NOT NULL, 
    host_response_time VARCHAR(500), 
    host_response_rate INT, 
    host_acceptance_rate INT, 
    host_is_superhost VARCHAR(1) NOT NULL, 
    host_thumbnail_url VARCHAR(200) NOT NULL, 
    host_picture_url VARCHAR(200) NOT NULL, 
    host_neighbourhood VARCHAR(20) NOT NULL, 
    host_listings_count INT NOT NULL, 
    host_total_listings_count INT NOT NULL, 
    host_verifications VARCHAR(100) NOT NULL, 
    host_has_profile_pic VARCHAR(1) NOT NULL, 
    host_identity_verified VARCHAR(1) NOT NULL,
    PRIMARY KEY (host_id)
);

DROP TABLE IF EXISTS Listing;
CREATE TABLE Listing(
    listing_id INT NOT NULL,
    listing_url VARCHAR(100) NOT NULL, 
    name VARCHAR(100) NOT NULL, 
    description VARCHAR(2000) NOT NULL, 
    neighborhood_overview VARCHAR(2000) NOT NULL, 
    picture_url VARCHAR(100) NOT NULL, 
    host_id INT NOT NULL, 
    neighbourhood VARCHAR(20), 
    neighbourhood_cleansed VARCHAR(30) NOT NULL, -- Neighborhood.id? 
    latitude FLOAT NOT NULL, 
    longitude FLOAT NOT NULL, 
    property_type VARCHAR(20) NOT NULL, 
    room_type VARCHAR(20) NOT NULL, 
    accommodates INT NOT NULL, 
    bathrooms_text VARCHAR(20) NOT NULL, 
    bedrooms INT NOT NULL, 
    beds INT NOT NULL, 
    amenities VARCHAR(1000) NOT NULL, 
    price FLOAT NOT NULL, 
    minimum_nights INT NOT NULL, 
    maximum_nights INT NOT NULL, 
    availability_365 INT NOT NULL, 
    number_of_reviews INT NOT NULL, 
    first_review DATE NOT NULL, 
    last_review DATE NOT NULL, 
    review_scores_rating INT NOT NULL, 
    review_scores_accuracy INT NOT NULL, 
    review_scores_cleanliness INT NOT NULL, 
    review_scores_checkin INT NOT NULL, 
    review_scores_communication INT NOT NULL, 
    review_scores_location INT NOT NULL, 
    review_scores_value INT NOT NULL, 
    instant_bookable BOOLEAN NOT NULL, 
    calculated_host_listings_count INT NOT NULL, 
    calculated_host_listings_count_entire_homes INT NOT NULL, 
    calculated_host_listings_count_private_rooms INT NOT NULL,
    calculated_host_listings_count_shared_rooms INT NOT NULL, 
    reviews_per_month DECIMAL(3, 2) NOT NULL,
    PRIMARY KEY (listing_id),
    FOREIGN KEY (host_id) REFERENCES Host(host_id)
);


DROP TABLE IF EXISTS Reviewer;
CREATE TABLE Reviewer(
    reviewer_id INT NOT NULL,
    reviewer_name VARCHAR(20) NOT NULL,
    PRIMARY KEY (reviewer_id)
);

DROP TABLE IF EXISTS Review;
CREATE TABLE Review(
    review_id INT NOT NULL,
    listing_id INT NOT NULL,
    review_date DATE NOT NULL,
    reviewer_id INT NOT NULL,
    comments VARCHAR(2000),
    sentiment_score INT,
    PRIMARY KEY (review_id),
    FOREIGN KEY (listing_id) REFERENCES Listing(listing_id),
    FOREIGN KEY (reviewer_id) REFERENCES Reviewer(reviewer_id)
);


LOAD DATA INFILE '/Users/baobao/Desktop/JHU_Master/Fall2020/Databases/FinalProject/data/neighbourhoods.csv' 
INTO TABLE Neighbourhood
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(name, city, state, country);


LOAD DATA INFILE '/Users/baobao/Desktop/JHU_Master/Fall2020/Databases/FinalProject/data/hosts.csv' 
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


LOAD DATA INFILE '/Users/baobao/Desktop/JHU_Master/Fall2020/Databases/FinalProject/data/listings.csv' 
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


LOAD DATA INFILE '/Users/baobao/Desktop/JHU_Master/Fall2020/Databases/FinalProject/data/reviewers.csv' 
IGNORE
INTO TABLE Reviewer
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(reviewer_id, reviewer_name);


LOAD DATA INFILE '/Users/baobao/Desktop/JHU_Master/Fall2020/Databases/FinalProject/data/reviews.csv' 
IGNORE
INTO TABLE Review
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r'
IGNORE 1 ROWS
(listing_id, review_id, @review_date, reviewer_id, comments)
SET review_date = STR_TO_DATE(@review_date, '%m/%d/%Y');


# Replace neighbourhood_cleanse by zipcode(foreign key) in Listing
ALTER TABLE Listing
ADD zipcode INT;

ALTER TABLE Listing
ADD CONSTRAINT fk_neighborhood FOREIGN KEY (zipcode) REFERENCES Neighbourhood(zipcode);

UPDATE Listing
INNER JOIN Neighbourhood ON Listing.neighbourhood_cleansed = Neighbourhood.name
SET Listing.zipcode = Neighbourhood.zipcode;

ALTER TABLE Listing
DROP COLUMN neighbourhood_cleansed;
