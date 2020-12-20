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
		FROM Zipcode as Z, Covid as C, ParkScore as P
		WHERE Z.airbnb_neighbourhood = neighborhood
			AND Z.covid_neighborhood = C.neighborhood
			AND Z.zipcode = P.Zipcode;
	ELSE
		SELECT 'No data is found.' AS 'Error Message';
	END IF;
END;
//

-- CALL NeighborhoodInfo('Western Addition');//

-- listing search procedure
DROP PROCEDURE IF EXISTS ListingSearch; //
CREATE PROCEDURE ListingSearch(IN neighborhood VARCHAR(30), IN room_type VARCHAR(20), IN accommodates INT, IN bedrooms INT, IN beds INT, IN price_low DECIMAL(8,2), IN price_high DECIMAL(8,2))

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
		SELECT L.listing_id, L.listing_url, L.name, L.description, L.neighborhood_overview, L.picture_url, L.host_id, L.property_type, L.amenities, L.price, L.number_of_reviews, L.review_scores_rating, L.bathrooms_text
		FROM Listing AS L
		WHERE L.neighbourhood_cleansed = neighborhood 
			AND L.room_type = room_type 
			AND L.accommodates >= accommodates 
			AND L.bedrooms >= bedrooms 
			AND L.beds >= beds 
			AND L.price >= price_low 
			AND L.price <= price_high
			LIMIT 10;
	ELSE
		SELECT 'No data is found.' AS 'Error Message';
	END IF;
END;
//



-- listing search procedure and sort by price
DROP PROCEDURE IF EXISTS ListingSearchSortByPrice; //
CREATE PROCEDURE ListingSearchSortByPrice(IN neighborhood VARCHAR(30), IN room_type VARCHAR(20), IN accommodates INT, IN bedrooms INT, IN beds INT, IN price_low DECIMAL(8,2), IN price_high DECIMAL(8,2))

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
		SELECT L.listing_id, L.listing_url, L.name, L.description, L.neighborhood_overview, L.picture_url, L.host_id, L.property_type, L.amenities, L.price, L.number_of_reviews, L.review_scores_rating, L.bathrooms_text
		FROM Listing AS L
		WHERE L.neighbourhood_cleansed = neighborhood 
			AND L.room_type = room_type 
			AND L.accommodates >= accommodates 
			AND L.bedrooms >= bedrooms 
			AND L.beds >= beds 
			AND L.price >= price_low 
			AND L.price <= price_high
		ORDER BY L.price
		LIMIT 10;
	ELSE
		SELECT 'No data is found.' AS 'Error Message';
	END IF;
END;
//

-- listing search procedure and sort by price
DROP PROCEDURE IF EXISTS ListingSearchSortByReview; //
CREATE PROCEDURE ListingSearchSortByReview(IN neighborhood VARCHAR(30), IN room_type VARCHAR(20), IN accommodates INT, IN bedrooms INT, IN beds INT, IN price_low DECIMAL(8,2), IN price_high DECIMAL(8,2))

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
		SELECT L.listing_id, L.listing_url, L.name, L.description, L.neighborhood_overview, L.picture_url, L.host_id, L.property_type, L.amenities, L.price, L.number_of_reviews, L.review_scores_rating, L.bathrooms_text
		FROM Listing AS L
		WHERE L.neighbourhood_cleansed = neighborhood 
			AND L.room_type = room_type 
			AND L.accommodates >= accommodates 
			AND L.bedrooms >= bedrooms 
			AND L.beds >= beds 
			AND L.price >= price_low 
			AND L.price <= price_high
		ORDER BY L.number_of_reviews DESC
		LIMIT 10;
	ELSE
		SELECT 'No data is found.' AS 'Error Message';
	END IF;
END;
//

-- listing search procedure and sort by price
DROP PROCEDURE IF EXISTS ListingSearchSortByRating; //
CREATE PROCEDURE ListingSearchSortByRating(IN neighborhood VARCHAR(30), IN room_type VARCHAR(20), IN accommodates INT, IN bedrooms INT, IN beds INT, IN price_low DECIMAL(8,2), IN price_high DECIMAL(8,2))

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
			L.host_id, L.property_type, L.amenities, L.price, L.number_of_reviews, L.review_scores_rating, L.bathrooms_text
		FROM Listing AS L
		WHERE L.neighbourhood_cleansed = neighborhood 
			AND L.room_type = room_type 
			AND L.accommodates >= accommodates 
			AND L.bedrooms >= bedrooms 
			AND L.beds >= beds 
			AND L.price >= price_low 
			AND L.price <= price_high
		ORDER BY L.review_scores_rating DESC
		LIMIT 10;
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
			L.property_type, L.price, L.number_of_reviews, L.review_scores_rating, L.bathrooms_text
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

-- CALL ListingSearch('Western Addition', 'Entire home/apt', 3, 1, 2, 100, 150);//