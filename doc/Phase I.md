Final Project Phase I

data source: [Inside Airbnb](http://insideairbnb.com/get-the-data.html)

(1) Who are your team members

	Nanxi Ye and Linghao Jin

(2) Target domain

	Airbnb listing information in San Francisco, CA

(3) List of questions
	
	Show the listings start hosting in 2008 with review score over 95.
	Show the name, host_acceptance_time and host_response_rate of the hosts who have more than 3 listings currently.
	Show the listings by hosts who is related to UCSF in their host_about.
	Show host_response_time and host_response_rate of those who have different host_location and listing location.
	Show listings that offers entire home/apartment with more than 3 accommodations and coffee maker in neighborhood Financial District.
	Show the average price of listings in Financial District.
	Show the average rating of listings with price less than $100, between $100 and $200, between $200 and $300 and above $300.
	Show listings from hosts who were originally not from San Francisco. (from host_about)

(4) Relational data model

	Listing(id(primary), name, description, host_id(foreign), neighborhood(foreign), review_id(foreign), accommodation, bathrooms, bedrooms, beds)
	host(host_id(primary), host_url, host_name, host_location, host_about)
	neighborhood(neighborhood(primary))
	review(id(primary), listing_id(foreign), reviewer_id(foreign), comments)
	reviewer(reviewer_id, reviewer_name)

(5) SQL statements for representative sample of target queries



(6) How to load the database with values

	csv -> sql? csv -> python?

(7) Result of project

	like hw3

(8) Topics of database design


Questions for prof on Monday:

(7)