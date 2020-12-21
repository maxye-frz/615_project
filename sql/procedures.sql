DELIMITER //

-- view

DROP VIEW IF EXISTS ParkScore;//
CREATE View ParkScore AS
SELECT Zipcode, COUNT(Zipcode) AS count, AVG(score) AS avg_score
FROM Park
WHERE Zipcode >= 90000
GROUP BY Zipcode;
//


-- show neighborhood info
DROP PROCEDURE IF EXISTS NeighborhoodInfo;//
CREATE PROCEDURE NeighborhoodInfo(IN neighborhood VARCHAR(30))
BEGIN
	IF EXISTS (SELECT *
				FROM Zipcode AS Z
				WHERE Z.airbnb_neighbourhood = neighborhood) THEN
		SELECT Z.zipcode, Z.airbnb_neighbourhood, C.resident_population, C.cumulative_cases, C.Rate_of_cases_per_10000, C.new_cases, C.Rate_of_new_cases_per_10000, P.avg_score
		FROM Zipcode as Z
        Join Covid as C ON Z.covid_neighborhood = C.neighborhood
        LEFT JOIN ParkScore as P ON Z.zipcode = P.Zipcode
		WHERE Z.airbnb_neighbourhood = neighborhood;
	ELSE
		SELECT 'No data is found.' AS 'Error Message';
	END IF;
END;
//

-- CALL NeighborhoodInfo('Western Addition');//

-- listing search procedure
DROP PROCEDURE IF EXISTS ListingSearch; //
CREATE PROCEDURE ListingSearch(IN neighborhood VARCHAR(30), IN room_type VARCHAR(20), IN accommodates INT, IN bedrooms INT, IN beds INT, IN price_low DECIMAL(8,2), IN price_high DECIMAL(8,2), IN offset INT, IN no_of_records_per_page INT)

BEGIN
    IF EXISTS (SELECT listing_id 
                FROM Listing AS L 
                WHERE L.neighbourhood_cleansed = neighborhood 
                    AND L.room_type = room_type 
                    AND L.accommodates >= accommodates 
                    AND L.bedrooms = bedrooms 
                    AND L.beds = beds 
                    AND L.price > price_low 
                    AND L.price < price_high) THEN
        SELECT L.listing_id, L.listing_url, L.name, L.description, L.neighborhood_overview, L.picture_url, L.host_id, L.property_type, L.amenities, L.price, L.number_of_reviews, L.review_scores_rating, L.bathrooms_text, L.latitude, L.longitude
        FROM Listing AS L
        WHERE L.neighbourhood_cleansed = neighborhood 
            AND L.room_type = room_type 
            AND L.accommodates >= accommodates 
            AND L.bedrooms >= bedrooms 
            AND L.beds >= beds 
            AND L.price >= price_low 
            AND L.price <= price_high
            LIMIT offset, no_of_records_per_page;
    ELSE
        SELECT 'No data is found.' AS 'Error Message';
    END IF;
END;
//

-- listing search procedure and sort by price
DROP PROCEDURE IF EXISTS ListingSearchSortByPrice; //
CREATE PROCEDURE ListingSearchSortByPrice(IN neighborhood VARCHAR(30), IN room_type VARCHAR(20), 
        IN accommodates INT, IN bedrooms INT, IN beds INT, IN price_low DECIMAL(8,2), IN price_high DECIMAL(8,2), 
        IN offset INT, IN no_of_records_per_page INT)

BEGIN
    IF EXISTS (SELECT listing_id 
                FROM Listing AS L 
                WHERE L.neighbourhood_cleansed = neighborhood 
                    AND L.room_type = room_type 
                    AND L.accommodates >= accommodates 
                    AND L.bedrooms = bedrooms 
                    AND L.beds = beds 
                    AND L.price > price_low 
                    AND L.price < price_high) THEN
        SELECT L.listing_id, L.listing_url, L.name, L.description, L.neighborhood_overview, L.picture_url, 
            L.host_id, L.property_type, L.amenities, L.price, L.number_of_reviews, L.review_scores_rating, 
            L.bathrooms_text, L.latitude, L.longitude
        FROM Listing AS L
        WHERE L.neighbourhood_cleansed = neighborhood 
            AND L.room_type = room_type 
            AND L.accommodates >= accommodates 
            AND L.bedrooms >= bedrooms 
            AND L.beds >= beds 
            AND L.price >= price_low 
            AND L.price <= price_high
        ORDER BY L.price
        LIMIT offset, no_of_records_per_page;
    ELSE
        SELECT 'No data is found.' AS 'Error Message';
    END IF;
END;
//


-- listing search procedure and sort by price
DROP PROCEDURE IF EXISTS ListingSearchSortByReview; //
CREATE PROCEDURE ListingSearchSortByReview(IN neighborhood VARCHAR(30), IN room_type VARCHAR(20), 
    IN accommodates INT, IN bedrooms INT, IN beds INT, IN price_low DECIMAL(8,2), IN price_high DECIMAL(8,2), 
    IN offset INT, IN no_of_records_per_page INT)

BEGIN
    IF EXISTS (SELECT listing_id 
                FROM Listing AS L 
                WHERE L.neighbourhood_cleansed = neighborhood 
                    AND L.room_type = room_type 
                    AND L.accommodates >= accommodates 
                    AND L.bedrooms = bedrooms 
                    AND L.beds = beds 
                    AND L.price > price_low 
                    AND L.price < price_high) THEN
        SELECT L.listing_id, L.listing_url, L.name, L.description, L.neighborhood_overview, 
            L.picture_url, L.host_id, L.property_type, L.amenities, L.price, L.number_of_reviews, 
            L.review_scores_rating, L.bathrooms_text, L.latitude, L.longitude
        FROM Listing AS L
        WHERE L.neighbourhood_cleansed = neighborhood 
            AND L.room_type = room_type 
            AND L.accommodates >= accommodates 
            AND L.bedrooms >= bedrooms 
            AND L.beds >= beds 
            AND L.price >= price_low 
            AND L.price <= price_high
        ORDER BY L.number_of_reviews DESC
        LIMIT offset, no_of_records_per_page;
    ELSE
        SELECT 'No data is found.' AS 'Error Message';
    END IF;
END;
//

-- listing search procedure and sort by price
DROP PROCEDURE IF EXISTS ListingSearchSortByRating; //
CREATE PROCEDURE ListingSearchSortByRating(IN neighborhood VARCHAR(30), IN room_type VARCHAR(20),
    IN accommodates INT, IN bedrooms INT, IN beds INT, IN price_low DECIMAL(8,2), IN price_high DECIMAL(8,2), 
    IN offset INT, IN no_of_records_per_page INT)

BEGIN
    IF EXISTS (SELECT listing_id 
                FROM Listing AS L 
                WHERE L.neighbourhood_cleansed = neighborhood 
                    AND L.room_type = room_type 
                    AND L.accommodates >= accommodates 
                    AND L.bedrooms = bedrooms 
                    AND L.beds = beds 
                    AND L.price > price_low 
                    AND L.price < price_high) THEN
        SELECT L.listing_id, L.listing_url, L.name, L.description, L.neighborhood_overview, L.picture_url, 
            L.host_id, L.property_type, L.amenities, L.price, L.number_of_reviews, L.review_scores_rating, L.bathrooms_text, 
            L.latitude, L.longitude
        FROM Listing AS L
        WHERE L.neighbourhood_cleansed = neighborhood 
            AND L.room_type = room_type 
            AND L.accommodates >= accommodates 
            AND L.bedrooms >= bedrooms 
            AND L.beds >= beds 
            AND L.price >= price_low 
            AND L.price <= price_high
        ORDER BY L.review_scores_rating DESC
        LIMIT offset, no_of_records_per_page;
    ELSE
        SELECT 'No data is found.' AS 'Error Message';
    END IF;
END;
//

DROP PROCEDURE IF EXISTS FindListingByID; //
CREATE PROCEDURE FindListingByID(IN listing_id INT)
BEGIN
    IF EXISTS(SELECT listing_id FROM Listing) THEN
        SELECT L.name, L.neighbourhood_cleansed, L.picture_url, L.description, L.amenities, L.host_id, L.neighborhood_overview, 
            L.property_type, L.price, L.number_of_reviews, L.review_scores_rating, L.bathrooms_text, L.latitude, L.longitude
        FROM Listing AS L
        WHERE L.listing_id = listing_id;
    ELSE
        SELECT 'No data is found.' AS 'Error Message';
    END IF;
END;
//

DROP PROCEDURE IF EXISTS FindHostByID; //
CREATE PROCEDURE FindHostByID(IN host_id INT)
BEGIN
    IF EXISTS(SELECT host_id FROM Host) THEN
        SELECT host_id, host_name, host_since, host_about, host_picture_url, host_neighbourhood
        FROM Host AS H
        WHERE H.host_id = host_id;
    ELSE
        SELECT 'No data is found.' AS 'Error Message';
    END IF;
END;
//

DROP PROCEDURE IF EXISTS FindReviewByListingID; //
CREATE PROCEDURE FindReviewByListingID(IN listing_id INT)
BEGIN
    IF EXISTS(SELECT listing_id FROM Review) THEN
        SELECT Review.review_date, Review.comments, Reviewer.reviewer_name
        FROM Review, Reviewer
        WHERE Review.reviewer_id = Reviewer.reviewer_id 
            AND Review.listing_id = listing_id;
    ELSE
        SELECT 'No data is found.' AS 'Error Message';
    END IF;
END;
//


DROP PROCEDURE IF EXISTS UpdateHost;  //
CREATE PROCEDURE UpdateHost(IN host_id INT, 
    					IN host_url TEXT, 
    					IN host_name TEXT, 
    					IN host_since DATE, 
    					IN host_location TEXT,
    					IN host_about TEXT, 
    					IN host_response_time TEXT, 
    					IN host_response_rate INT, 
    					IN host_acceptance_rate INT, 
    					IN host_is_superhost VARCHAR(1), 
    					IN host_thumbnail_url TEXT,
    					IN host_picture_url TEXT,
    					IN host_neighbourhood TEXT, 
    					IN host_listings_count INT,
    					IN host_total_listings_count INT,
    					IN host_verifications TEXT, 
    					IN host_has_profile_pic VARCHAR(1), 
    					IN host_identity_verified VARCHAR(2))
BEGIN
	INSERT INTO Host 
	VALUES (host_id, 
    		host_url, 
    		host_name, 
    		host_since, 
    		host_location,
    		host_about, 
    		host_response_time, 
    		host_response_rate, 
    		host_acceptance_rate, 
    		host_is_superhost, 
    		host_thumbnail_url, 
   			host_picture_url, 
    		host_neighbourhood, 
    		host_listings_count, 
    		host_total_listings_count, 
    		host_verifications, 
    		host_has_profile_pic, 
    		host_identity_verified)
	ON DUPLICATE KEY UPDATE
	host_url = VALUES(host_url), 
    host_name = VALUES(host_name), 
    host_since = VALUES(host_since), 
    host_location = VALUES(host_location),
    host_about = VALUES(host_about), 
    host_response_time = VALUES(host_response_time), 
    host_response_rate = VALUES(host_response_rate), 
    host_acceptance_rate = VALUES(host_acceptance_rate), 
    host_is_superhost = VALUES(host_is_superhost), 
    host_thumbnail_url = VALUES(host_thumbnail_url), 
   	host_picture_url = VALUES(host_picture_url), 
    host_neighbourhood = VALUES(host_neighbourhood), 
    host_listings_count = VALUES(host_listings_count), 
    host_total_listings_count = VALUES(host_total_listings_count), 
    host_verifications = VALUES(host_verifications), 
    host_has_profile_pic = VALUES(host_has_profile_pic), 
    host_identity_verified = VALUES(host_identity_verified);
END;
//

-- CALL UpdateHost(1234, 'real url', 'fake host', '2020-12-12', 'baltimore', 'this is a fake host', 'reponse time', 99, 99, 'f', 'thumbnail_url', 'picture_url',
-- 'neighbourhood', 9, 9, 'email', 't', 'f');//
-- CALL UpdateHost(1234, 'change url', 'fake host', '2020-12-12', 'baltimore', 'this is a fake host', 'reponse time', 99, 99, 'f', 'thumbnail_url', 'picture_url',
-- 'neighbourhood', 9, 9, 'email', 't', 'f');//

DROP PROCEDURE IF EXISTS DeleteHost; //
CREATE PROCEDURE DeleteHost(IN host_id INT)
BEGIN
	IF EXISTS (SELECT Host.host_id FROM Host WHERE Host.host_id = host_id) THEN
	DELETE FROM Host WHERE Host.host_id = host_id;
	END IF;
END;
//
-- CALL DeleteHost(1234);//


DROP PROCEDURE IF EXISTS CheckHost; //
CREATE PROCEDURE CheckHost(IN host_id INT)
BEGIN
	IF EXISTS (SELECT Host.host_id FROM Host WHERE Host.host_id = host_id) THEN
		SELECT 'Host exists' AS 'Message';
	ELSE
		SELECT 'Host does not exists' AS 'Message';
	END IF;
END;
//

-- CALL CheckHost(1169);//
-- CALL CheckHost(1234);//

DROP PROCEDURE IF EXISTS UpdateListing;  //
CREATE PROCEDURE UpdateListing(IN listing_id INT, 
	IN listing_url TEXT, 
    IN name TEXT, 
    IN description TEXT, 
    IN neighborhood_overview TEXT, 
    IN picture_url TEXT, 
    IN host_id INT, 
    IN neighbourhood VARCHAR(100), 
    IN neighbourhood_cleansed VARCHAR(30), 
    IN latitude FLOAT, 
    IN longitude FLOAT, 
    IN property_type VARCHAR(100), 
    IN room_type VARCHAR(20), 
    IN accommodates INT, 
    IN bathrooms_text VARCHAR(20), 
    IN bedrooms INT, 
    IN beds INT, 
    IN amenities TEXT, 
    IN price DECIMAL(8, 2), 
    IN minimum_nights INT, 
    IN maximum_nights INT, 
    IN availability_365 INT, 
    IN number_of_reviews INT, 
    IN first_review DATE, 
    IN last_review DATE, 
    IN review_scores_rating INT, 
    IN review_scores_accuracy INT, 
    IN review_scores_cleanliness INT, 
    IN review_scores_checkin INT, 
    IN review_scores_communication INT, 
    IN review_scores_location INT, 
    IN review_scores_value INT, 
    IN instant_bookable VARCHAR(1), 
    IN calculated_host_listings_count INT, 
    IN calculated_host_listings_count_entire_homes INT, 
    IN calculated_host_listings_count_private_rooms INT,
    IN calculated_host_listings_count_shared_rooms INT, 
    IN reviews_per_month DECIMAL(3, 2))
BEGIN
	INSERT INTO Listing 
	VALUES (listing_id, 
			listing_url, 
 			name, 
 			description, 
			neighborhood_overview, 
    		picture_url, 
    		host_id, 
    		neighbourhood, 
    		neighbourhood_cleansed, 
    		latitude, 
    		longitude, 
    		property_type, 
    		room_type, 
    		accommodates, 
    		bathrooms_text, 
    		bedrooms, 
    		beds, 
    		amenities, 
    		price, 
    		minimum_nights, 
    		maximum_nights, 
    		availability_365, 
    		number_of_reviews, 
    		first_review, 
    		last_review, 
    		review_scores_rating, 
    		review_scores_accuracy, 
    		review_scores_cleanliness, 
    		review_scores_checkin, 
    		review_scores_communication, 
    		review_scores_location, 
    		review_scores_value, 
    		instant_bookable, 
    		calculated_host_listings_count, 
    		calculated_host_listings_count_entire_homes, 
    		calculated_host_listings_count_private_rooms,
    		calculated_host_listings_count_shared_rooms, 
    		reviews_per_month)
	ON DUPLICATE KEY UPDATE
		listing_url = VALUES(listing_url), 
 		name = VALUES(name), 
 		description = VALUES(description), 
		neighborhood_overview = VALUES(neighborhood_overview), 
    	picture_url = VALUES(picture_url), 
    	host_id = VALUES(host_id), 
    	neighbourhood = VALUES(neighbourhood), 
    	neighbourhood_cleansed = VALUES(neighbourhood_cleansed), 
    	latitude = VALUES(latitude), 
    	longitude = VALUES(longitude), 
    	property_type = VALUES(property_type), 
    	room_type = VALUES(room_type), 
    	accommodates = VALUES(accommodates), 
    	bathrooms_text = VALUES(bathrooms_text), 
    	bedrooms = VALUES(bedrooms), 
    	beds = VALUES(beds), 
    	amenities = VALUES(amenities), 
    	price = VALUES(price), 
    	minimum_nights = VALUES(minimum_nights), 
    	maximum_nights = VALUES(maximum_nights), 
    	availability_365 = VALUES(availability_365), 
    	number_of_reviews = VALUES(number_of_reviews), 
    	first_review = VALUES(first_review), 
    	last_review = VALUES(last_review), 
    	review_scores_rating = VALUES(review_scores_rating), 
    	review_scores_accuracy = VALUES(review_scores_accuracy), 
    	review_scores_cleanliness = VALUES(review_scores_cleanliness), 
    	review_scores_checkin = VALUES(review_scores_checkin), 
    	review_scores_communication = VALUES(review_scores_communication), 
    	review_scores_location = VALUES(review_scores_location), 
    	review_scores_value = VALUES(review_scores_value), 
    	instant_bookable = VALUES(instant_bookable), 
    	calculated_host_listings_count = VALUES(calculated_host_listings_count), 
    	calculated_host_listings_count_entire_homes = VALUES(calculated_host_listings_count_entire_homes), 
    	calculated_host_listings_count_private_rooms = VALUES(calculated_host_listings_count_private_rooms),
    	calculated_host_listings_count_shared_rooms = VALUES(calculated_host_listings_count_shared_rooms), 
    	reviews_per_month = VALUES(reviews_per_month);
END;
//

-- CALL UpdateListing(1234, 'www', 'big room', 'desc', 'nb overview', 'url', 1169, 'sf', 'Western Addition', 37.7000, -122.333, 'Entire', 'apt', 4, 'no bath??', 1, 1, 'ps5', 99.99, 1, 30, 200, 200, '2008-08-08', '2020-10-15', 99, 9, 9, 9, 9, 8, 9, 'f', 2, 3, 0, 0, 1.3);//


DROP PROCEDURE IF EXISTS DeleteListing; //
CREATE PROCEDURE DeleteListing(IN listing_id INT)
BEGIN
	IF EXISTS (SELECT Listing.listing_id FROM Listing WHERE Listing.listing_id = listing_id) THEN
	DELETE FROM Listing WHERE Listing.listing_id = listing_id;
	END IF;
END;
//
-- CALL DeleteListing(1234);//

DROP PROCEDURE IF EXISTS WordSearch; //
CREATE PROCEDURE WordSearch(IN inputWord TEXT, IN offset INT, IN no_of_records_per_page INT)
BEGIN
    SELECT listing_id
    FROM Listing
    WHERE name LIKE CONCAT('%', inputWord, '%') OR description LIKE CONCAT('%', inputWord, '%') OR neighborhood_overview LIKE CONCAT('%', inputWord, '%') OR amenities LIKE CONCAT('%', inputWord, '%');
END;
//

-- listing search with words procedure
DROP PROCEDURE IF EXISTS WordListingSearch; //
CREATE PROCEDURE WordListingSearch(IN inputWord TEXT, IN neighborhood VARCHAR(30), IN room_type VARCHAR(20), IN accommodates INT, IN bedrooms INT, IN beds INT, IN price_low DECIMAL(8,2), IN price_high DECIMAL(8,2), IN offset INT, IN no_of_records_per_page INT)

BEGIN
    IF EXISTS (SELECT listing_id 
                FROM Listing AS L 
                WHERE L.neighbourhood_cleansed = neighborhood 
                    AND L.room_type = room_type 
                    AND L.accommodates >= accommodates 
                    AND L.bedrooms = bedrooms 
                    AND L.beds = beds 
                    AND L.price > price_low 
                    AND L.price < price_high) THEN
        SELECT s.listing_id, s.listing_url, s.name, s.description, s.neighborhood_overview, s.picture_url, 
            s.host_id, s.property_type, s.amenities, s.price, s.number_of_reviews, s.review_scores_rating, 
            s.bathrooms_text, s.latitude, s.longitude
        FROM (SELECT L.listing_id, L.listing_url, L.name, L.description, L.neighborhood_overview, L.picture_url, 
                L.host_id, L.property_type, L.amenities, L.price, L.number_of_reviews, L.review_scores_rating, 
                L.bathrooms_text, L.latitude, L.longitude
                FROM Listing as L
                WHERE L.neighbourhood_cleansed = neighborhood 
                AND L.room_type = room_type 
                AND L.accommodates >= accommodates 
                AND L.bedrooms >= bedrooms 
                AND L.beds >= beds 
                AND L.price >= price_low 
                AND L.price <= price_high) AS s
        WHERE s.name LIKE CONCAT('%', inputWord, '%') OR s.description LIKE CONCAT('%', inputWord, '%') OR 
            s.neighborhood_overview LIKE CONCAT('%', inputWord, '%') OR s.amenities LIKE CONCAT('%', inputWord, '%')
        LIMIT offset, no_of_records_per_page;
    ELSE
        SELECT 'No data is found.' AS 'Error Message';
    END IF;
END;
//
-- call WordListingSearch('cul de sac', 'Western Addition', 'Entire home/apt', 3, 1, 2, 100, 150, 0, 10);//


-- listing search procedure and sort by price
DROP PROCEDURE IF EXISTS WordListingSearchSortByPrice; //
CREATE PROCEDURE WordListingSearchSortByPrice(IN inputWord TEXT, IN neighborhood VARCHAR(30), IN room_type VARCHAR(20), IN accommodates INT, IN bedrooms INT, IN beds INT, IN price_low DECIMAL(8,2), IN price_high DECIMAL(8,2), IN offset INT, IN no_of_records_per_page INT)

BEGIN
    IF EXISTS (SELECT listing_id 
                FROM Listing AS L 
                WHERE L.neighbourhood_cleansed = neighborhood 
                    AND L.room_type = room_type 
                    AND L.accommodates >= accommodates 
                    AND L.bedrooms = bedrooms 
                    AND L.beds = beds 
                    AND L.price > price_low 
                    AND L.price < price_high) THEN
        SELECT s.listing_id, s.listing_url, s.name, s.description, s.neighborhood_overview, s.picture_url, s.host_id, 
            s.property_type, s.amenities, s.price, s.number_of_reviews, s.review_scores_rating, 
            s.bathrooms_text, s.latitude, s.longitude
        FROM (SELECT L.listing_id, L.listing_url, L.name, L.description, L.neighborhood_overview, 
                L.picture_url, L.host_id, L.property_type, L.amenities, L.price, L.number_of_reviews, 
                L.review_scores_rating, L.bathrooms_text, L.latitude, L.longitude
                FROM Listing as L
                WHERE L.neighbourhood_cleansed = neighborhood 
                AND L.room_type = room_type 
                AND L.accommodates >= accommodates 
                AND L.bedrooms >= bedrooms 
                AND L.beds >= beds 
                AND L.price >= price_low 
                AND L.price <= price_high) AS s
        WHERE s.name LIKE CONCAT('%', inputWord, '%') OR s.description LIKE CONCAT('%', inputWord, '%') OR 
            s.neighborhood_overview LIKE CONCAT('%', inputWord, '%') OR s.amenities LIKE CONCAT('%', inputWord, '%')
        ORDER BY s.price
        LIMIT offset, no_of_records_per_page;
    ELSE
        SELECT 'No data is found.' AS 'Error Message';
    END IF;
END;
//


-- listing search procedure and sort by price
DROP PROCEDURE IF EXISTS WordListingSearchSortByReview; //
CREATE PROCEDURE WordListingSearchSortByReview(IN inputWord TEXT, IN neighborhood VARCHAR(30), IN room_type VARCHAR(20), 
    IN accommodates INT, IN bedrooms INT, IN beds INT, IN price_low DECIMAL(8,2), IN price_high DECIMAL(8,2), 
    IN offset INT, IN no_of_records_per_page INT)

BEGIN
    IF EXISTS (SELECT listing_id 
                FROM Listing AS L 
                WHERE L.neighbourhood_cleansed = neighborhood 
                    AND L.room_type = room_type 
                    AND L.accommodates >= accommodates 
                    AND L.bedrooms = bedrooms 
                    AND L.beds = beds 
                    AND L.price > price_low 
                    AND L.price < price_high) THEN
        SELECT s.listing_id, s.listing_url, s.name, s.description, s.neighborhood_overview, s.picture_url, 
            s.host_id, s.property_type, s.amenities, s.price, s.number_of_reviews, s.review_scores_rating, 
            s.bathrooms_text, s.latitude, s.longitude
        FROM (SELECT L.listing_id, L.listing_url, L.name, L.description, L.neighborhood_overview, 
                L.picture_url, L.host_id, L.property_type, L.amenities, L.price, L.number_of_reviews, 
                L.review_scores_rating, L.bathrooms_text, L.latitude, L.longitude
                FROM Listing as L
                WHERE L.neighbourhood_cleansed = neighborhood 
                AND L.room_type = room_type 
                AND L.accommodates >= accommodates 
                AND L.bedrooms >= bedrooms 
                AND L.beds >= beds 
                AND L.price >= price_low 
                AND L.price <= price_high) AS s
        WHERE s.name LIKE CONCAT('%', inputWord, '%') OR s.description LIKE CONCAT('%', inputWord, '%') OR 
        s.neighborhood_overview LIKE CONCAT('%', inputWord, '%') OR s.amenities LIKE CONCAT('%', inputWord, '%')
        ORDER BY s.number_of_reviews DESC
        LIMIT offset, no_of_records_per_page;
    ELSE
        SELECT 'No data is found.' AS 'Error Message';
    END IF;
END;
//

-- listing search procedure and sort by price
DROP PROCEDURE IF EXISTS WordListingSearchSortByRating; //
CREATE PROCEDURE WordListingSearchSortByRating(IN inputWord TEXT, IN neighborhood VARCHAR(30), IN room_type VARCHAR(20), 
    IN accommodates INT, IN bedrooms INT, IN beds INT, IN price_low DECIMAL(8,2), IN price_high DECIMAL(8,2), 
    IN offset INT, IN no_of_records_per_page INT)

BEGIN
    IF EXISTS (SELECT listing_id 
                FROM Listing AS L 
                WHERE L.neighbourhood_cleansed = neighborhood 
                    AND L.room_type = room_type 
                    AND L.accommodates >= accommodates 
                    AND L.bedrooms = bedrooms 
                    AND L.beds = beds 
                    AND L.price > price_low 
                    AND L.price < price_high) THEN
        SELECT s.listing_id, s.listing_url, s.name, s.description, s.neighborhood_overview, s.picture_url, 
            s.host_id, s.property_type, s.amenities, s.price, s.number_of_reviews, s.review_scores_rating, 
            s.bathrooms_text, s.latitude, s.longitude
        FROM (SELECT L.listing_id, L.listing_url, L.name, L.description, L.neighborhood_overview, 
                L.picture_url, L.host_id, L.property_type, L.amenities, L.price, L.number_of_reviews, 
                L.review_scores_rating, L.bathrooms_text, L.latitude, L.longitude
                FROM Listing as L
                WHERE L.neighbourhood_cleansed = neighborhood 
                AND L.room_type = room_type 
                AND L.accommodates >= accommodates 
                AND L.bedrooms >= bedrooms 
                AND L.beds >= beds 
                AND L.price >= price_low 
                AND L.price <= price_high) AS s
        WHERE s.name LIKE CONCAT('%', inputWord, '%') OR s.description LIKE CONCAT('%', inputWord, '%') OR 
        s.neighborhood_overview LIKE CONCAT('%', inputWord, '%') OR s.amenities LIKE CONCAT('%', inputWord, '%')
        ORDER BY s.review_scores_rating DESC
        LIMIT offset, no_of_records_per_page;
    ELSE
        SELECT 'No data is found.' AS 'Error Message';
    END IF;
END;
//


DROP PROCEDURE IF EXISTS ParkAnalysis; //
CREATE PROCEDURE ParkAnalysis()
BEGIN

    Select zipcode, COUNT(park) AS park_count, AVG(score) AS average_park_score, AVG(square_feet) AS average_square_feet
    FROM Park
    WHERE zipcode != 0
    GROUP BY zipcode
    ORDER BY zipcode ASC;

END;
//

DROP PROCEDURE IF EXISTS ListingAnalysis; //
CREATE PROCEDURE ListingAnalysis()
BEGIN
    SELECT neighbourhood_cleansed as neighborhood, 
            COUNT(listing_id) AS listing_count,
            AVG(review_scores_rating) AS average_review_rating,
            AVG(review_scores_accuracy) AS average_accuracy,
            AVG(review_scores_cleanliness) AS average_cleanliness,
            AVG(review_scores_checkin) AS average_checkin,
            AVG(review_scores_communication) AS average_communication,
            AVG(review_scores_location) AS average_location,
            AVG(review_scores_value) AS average_value
    FROM Listing
    GROUP BY neighbourhood_cleansed
    ORDER BY neighbourhood_cleansed ASC;
END;
//


DROP PROCEDURE IF EXISTS CovidAnalysis; //
CREATE PROCEDURE CovidAnalysis()
BEGIN
    SELECT * FROM Covid
    ORDER BY cumulative_cases DESC;
END;
//


DROP PROCEDURE IF EXISTS AllAnalysis; //
CREATE PROCEDURE AllAnalysis()
BEGIN
    SELECT z.airbnb_neighbourhood AS neighborhood,
            l.listing_count, l.average_review_rating,
            p.park_count, p.average_park_score,
            c.cumulative_cases, c.new_cases
    FROM Zipcode as z, 
        (SELECT neighbourhood_cleansed as neighborhood, 
            COUNT(listing_id) AS listing_count,
            AVG(review_scores_rating) AS average_review_rating,
            AVG(review_scores_accuracy) AS average_accuracy,
            AVG(review_scores_cleanliness) AS average_cleanliness,
            AVG(review_scores_checkin) AS average_checkin,
            AVG(review_scores_communication) AS average_communication,
            AVG(review_scores_location) AS average_location,
            AVG(review_scores_value) AS average_value
        FROM Listing
        GROUP BY neighbourhood_cleansed) as l, 
        (Select zipcode, COUNT(park) AS park_count, AVG(score) AS average_park_score
        FROM Park
        WHERE zipcode != 0
        GROUP BY zipcode) as p, 
        Covid as c
    WHERE z.airbnb_neighbourhood = l.neighborhood
    AND z.covid_neighborhood = c.neighborhood
    AND z.zipcode = p.zipcode
    ORDER BY z.airbnb_neighbourhood;
END;
//

DROP PROCEDURE IF EXISTS Location;  //
CREATE PROCEDURE Location()
BEGIN
    SELECT z.airbnb_neighbourhood AS neighborhood,
            l.listing_count, l.average_review_rating,
            p.park_count, p.average_park_score,
            c.cumulative_cases, c.new_cases
    FROM Zipcode as z, 
        (SELECT neighbourhood_cleansed as neighborhood, 
            COUNT(listing_id) AS listing_count,
            AVG(review_scores_rating) AS average_review_rating,
            AVG(review_scores_accuracy) AS average_accuracy,
            AVG(review_scores_cleanliness) AS average_cleanliness,
            AVG(review_scores_checkin) AS average_checkin,
            AVG(review_scores_communication) AS average_communication,
            AVG(review_scores_location) AS average_location,
            AVG(review_scores_value) AS average_value
        FROM Listing
        GROUP BY neighbourhood_cleansed) as l, 
        (Select zipcode, COUNT(park) AS park_count, AVG(score) AS average_park_score
        FROM Park
        WHERE zipcode != 0
        GROUP BY zipcode) as p, 
        Covid as c
    WHERE z.airbnb_neighbourhood = l.neighborhood
    AND z.covid_neighborhood = c.neighborhood
    AND z.zipcode = p.zipcode
    ORDER BY z.airbnb_neighbourhood;
END;
//


DROP PROCEDURE IF EXISTS HealthRec;  //
CREATE PROCEDURE HealthRec()
BEGIN
    SELECT z.airbnb_neighbourhood AS neighborhood,
            l.listing_count, l.average_location_rating,
            p.park_count,
            c.cumulative_cases, 
            c.new_cases,
            c.new_cases/c.cumulative_cases AS new_to_cumulative_ratio
    FROM Zipcode as z, 
        (SELECT neighbourhood_cleansed as neighborhood, 
            COUNT(listing_id) AS listing_count,
            AVG(review_scores_location) AS average_location_rating
        FROM Listing
        GROUP BY neighbourhood_cleansed) as l,
        (Select zipcode, COUNT(park) AS park_count, AVG(score) AS average_park_score
        FROM Park
        WHERE zipcode != 0
        GROUP BY zipcode) as p,  
        Covid as c
    WHERE z.airbnb_neighbourhood = l.neighborhood
    AND z.covid_neighborhood = c.neighborhood
    AND z.zipcode = p.zipcode
    AND cumulative_cases != 'NULL'
    ORDER BY new_to_cumulative_ratio ASC, l.average_location_rating DESC, p.park_count DESC;
END;
//

DROP PROCEDURE IF EXISTS CountListingSearch;  //
CREATE PROCEDURE CountListingSearch(IN neighborhood VARCHAR(30), IN room_type VARCHAR(20), IN accommodates INT, 
    IN bedrooms INT, IN beds INT, IN price_low DECIMAL(8,2), IN price_high DECIMAL(8,2))
BEGIN
    SELECT COUNT(*)
    FROM Listing AS L
    WHERE L.neighbourhood_cleansed = neighborhood 
        AND L.room_type = room_type 
        AND L.accommodates >= accommodates 
        AND L.bedrooms >= bedrooms 
        AND L.beds >= beds 
        AND L.price >= price_low 
        AND L.price <= price_high;
END;
//

DROP PROCEDURE IF EXISTS CountWordSearch;  //
CREATE PROCEDURE CountWordSearch(IN inputWord TEXT, IN neighborhood VARCHAR(30), IN room_type VARCHAR(20), 
    IN accommodates INT, IN bedrooms INT, IN beds INT, IN price_low DECIMAL(8,2), IN price_high DECIMAL(8,2))
BEGIN
    SELECT COUNT(*)
    FROM (SELECT L.listing_id, L.listing_url, L.name, L.description, L.neighborhood_overview, L.picture_url, 
            L.host_id, L.property_type, L.amenities, L.price, L.number_of_reviews, L.review_scores_rating, L.bathrooms_text
                FROM Listing as L
                WHERE L.neighbourhood_cleansed = neighborhood 
                AND L.room_type = room_type 
                AND L.accommodates >= accommodates 
                AND L.bedrooms >= bedrooms 
                AND L.beds >= beds 
                AND L.price >= price_low 
                AND L.price <= price_high) AS s
    WHERE s.name LIKE CONCAT('%', inputWord, '%') OR s.description LIKE CONCAT('%', inputWord, '%') 
        OR s.neighborhood_overview LIKE CONCAT('%', inputWord, '%') OR s.amenities LIKE CONCAT('%', inputWord, '%');
END;
//
