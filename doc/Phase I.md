Final Project Phase I

data source: [Inside Airbnb](http://insideairbnb.com/get-the-data.html)

(1) Who are your team members

	Nanxi Ye and Linghao Jin

(2) Target domain

	Airbnb listing information in San Francisco, CA

(3) List of questions
	
	(1) Show the listings start hosting in 2008 with review score over 95.
	(2) Show the name, host_acceptance_time and host_response_rate of the hosts who have more than 3 listings currently.
	(3) Show the listings by hosts who is related to UCSF in their host_about.
	(4) Show host_response_time and host_response_rate of those who have different host_location and listing location.
	(5) Show listings that offers entire home/apartment with more than 3 accommodations and coffee maker in neighborhood Financial District.
	(6) Show the average price of listings in Financial District.
	(7) Show the average rating of listings with price less than $100, between $100 and $200, between $200 and $300 and above $300.
	(8) Show listings from hosts who were originally not from San Francisco. (from host_about)
	(9) Show the average rental price of each neighborhood in San Francisco.
	(10) Show the entire houses that are 20 miles (Euclidean distance) away from my current location.
	(11) Show the percentage of reviewers have reviewed multiple listings under 50 in Airbnb.
	(12) Show the review rating score stats(average, max, min) or listings group by property type, order by average review rating score.
	(13) Show the listings that are instant bookable, have over 50 reviews, rated above 90 and have over 30 days available in a year.
	(14) Show all the listings that owned by the same superhost who responses within an hour and are verified by government id.
	(15) Show the name of reviewers who reviewed most each year.
	(16) Show the listings that have good views (name including view) that are rated highest in each neighborhood.
	
(4) Relational data model

	Listing(id(primary), name, description, host_id(foreign), neighborhood(foreign), picture_url, price, property_type, room_type, accommodation, bathrooms, bedrooms, beds, amenities, minimum_nights, maximum nights, number_of_reviews, review_score_rating, instant_bookable, availability_365, longitude, latitude)
	host(host_id(primary), host_url, host_name, host_since, host_location, host_about, host_response_time, host_response_rate, host_acceptance_rate, host_is_superhost, host_neighborhood, host_verifications, host_listing_count)
	neighborhood(neighborhood(primary), city, state)
	review(id(primary), listing_id(foreign), reviewer_id(foreign), comments)
	reviewer(reviewer_id, reviewer_name)

(5) SQL statements for representative sample of target queries



(6) How to load the database with values

	load data local infile 'listings2.csv' into  table listings  
	fields terminated by ',' optionally enclosed by '"'   
	(id, name, description...);

	date data type;
	% to INT/DECIMAL;
	composite attribute store to table;

(7) Result of project

	like hw3//

(8) Topics of database design


Questions for prof on Monday:

host_location, neighborhood, Neighborhood: ?
(4)? relational data model in what format? ER diagram?
Seperate review score table from Listing?
what to do for (7), (8)? Cant be like a real airbnb right?
final results from previous students?
presentation? report? a link?
