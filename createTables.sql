DROP TABLE Listing;
CREATE TABLE Listing(
	id INT NOT NULL,
	listing_url VARCHAR(100) NOT NULL, 
	name VARCHAR(100) NOT NULL, 
	description VARCHAR(2000) NOT NULL, 
	neighborhood_overview VARCHAR(2000) NOT NULL, 
	picture_url VARCHAR(100) NOT NULL, 
	host_id INT NOT NULL, 
	-- host_url VARCHAR(100) NOT NULL, 
	-- host_name VARCHAR(20) NOT NULL, 
	-- host_since VARCHAR(10)NOT NULL, 
	-- host_location VARCHAR(20) NOT NULL, 
	-- host_about VARCHAR(2000)NOT NULL, 
	-- host_response_time VARCHAR(50), 
	-- host_response_rate INT, 
	-- host_acceptance_rate INT NOT NULL, 
	-- host_is_superhost VARCHAR(1) NOT NULL, 
	-- host_thumbnail_url VARCHAR(100) NOT NULL, 
	-- host_picture_url VARCHAR(100) NOT NULL, 
	-- host_neighbourhood VARCHAR(20) NOT NULL, 
	-- host_listings_count INT NOT NULL, 
	-- host_total_listings_count INT NOT NULL, 
	-- host_verifications VARCHAR(100) NOT NULL, 
	-- host_has_profile_pic VARCHAR(1) NOT NULL, 
	-- host_identity_verified VARCHAR(1) NOT NULL, 
	neighbourhood VARCHAR(20) NOT NULL, 
	neighbourhood_cleansed VARCHAR(20) NOT NULL, -- Neighborhood.id?
	-- neighbourhood_group_cleansed VARCHAR(100), 
	latitude DECIMAL(8, 5) NOT NULL, 
	longitude DECIMAL(8, 5) NOT NULL, 
	property_type VARCHAR(20) NOT NULL, 
	room_type VARCHAR(20) NOT NULL, 
	accommodates INT NOT NULL, 
	-- bathrooms INT, 
	bathrooms_text VARCHAR(20) NOT NULL, 
	bedrooms INT NOT NULL, 
	beds INT NOT NULL, 
	amenities VARCHAR(1000) NOT NULL, 
	price DECIMAL NOT NULL, 
	minimum_nights INT NOT NULL, 
	maximum_nights INT NOT NULL, 
	-- minimum_minimum_nights INT, 
	-- maximum_minimum_nights INT, 
	-- minimum_maximum_nights INT, 
	-- maximum_maximum_nights INT, 
	-- minimum_nights_avg_ntm INT, 
	-- maximum_nights_avg_ntm INT, 
	-- calendar_updated VARCHAR(1), 
	-- has_availability VARCHAR(1), 
	-- availability_30 INT, 
	-- availability_60 INT, 
	-- availability_90 INT, 
	availability_365 INT NOT NULL, 
	-- calendar_last_scraped VARCHAR(15), 
	number_of_reviews INT NOT NULL, 
	-- number_of_reviews_ltm INT, 
	-- number_of_reviews_l30d INT, 
	first_review DATE NOT NULL, 
	last_review DATE NOT NULL, 
	review_scores_rating INT NOT NULL, 
	review_scores_accuracy INT NOT NULL, 
	review_scores_cleanliness INT NOT NULL, 
	review_scores_checkin INT NOT NULL, 
	review_scores_communication INT NOT NULL, 
	review_scores_location INT NOT NULL, 
	review_scores_value INT NOT NULL, 
	-- license VARCHAR(50), 
	instant_bookable BOOLEAN NOT NULL, 
	calculated_host_listings_count INT NOT NULL, 
	calculated_host_listings_count_entire_homes INT NOT NULL, 
	calculated_host_listings_count_private_rooms INT NOT NULL,
	calculated_host_listings_count_shared_rooms INT NOT NULL, 
	reviews_per_month DECIMAL(3, 2) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (host_id) REFERENCES Host.host_id
);

DROP TABLE Host;
CREATE TABLE Host(
	host_id INT NOT NULL, 
	host_url VARCHAR(100) NOT NULL, 
	host_name VARCHAR(20) NOT NULL, 
	host_since VARCHAR(10)NOT NULL, 
	host_location VARCHAR(20) NOT NULL, -- Neighborhood.id?
	host_about VARCHAR(2000)NOT NULL, 
	host_response_time VARCHAR(50), 
	host_response_rate INT, 
	host_acceptance_rate INT NOT NULL, 
	host_is_superhost VARCHAR(1) NOT NULL, 
	host_thumbnail_url VARCHAR(100) NOT NULL, 
	host_picture_url VARCHAR(100) NOT NULL, 
	host_neighbourhood VARCHAR(20) NOT NULL, 
	host_listings_count INT NOT NULL, 
	host_total_listings_count INT NOT NULL, 
	host_verifications VARCHAR(100) NOT NULL, 
	host_has_profile_pic VARCHAR(1) NOT NULL, 
	host_identity_verified VARCHAR(1) NOT NULL,
	PRIMARY KEY (host_id)
);

DROP TABLE Neighbourhood;
CREATE TABLE Neighbourhood(
	id INT NOT NULL,
	name VARCHAR(20) NOT NULL,
	city VARCHAR(20) NOT NULL,
	state VARCHAR(20) NOT NULL,
	country VARCHAR(20) NOT NULL,
	PRIMARY KEy (id)
)

DROP TABLE Review;
CREATE TABLE Review(
	id INT NOT NULL,
	listing_id INT NOT NULL,
	date DATE NOT NULL,
	reviewer_id INT NOT NULL,
	comments VARCHAR(2000),
	PRIMARY KEY (id),
	FOREIGN KEY (listing_id) REFERENCES Listing.id,
	FOREIGN KEY (reviewer_id) REFERENCES Reviewer.reviewer_id
)

DROP TABLE Reviewer;
CREATE TABLE Reviewer(
	reviewer_id INT NOT NULL,
	reviewer_name VARCHAR(20) NOT NULL,
	PRIMARY KEY (reviewer_id)
)
