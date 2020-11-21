Final Project Phase I

data source: [Inside Airbnb](http://insideairbnb.com/get-the-data.html)

(1) Who are your team members

	Nanxi Ye and Linghao Jin

(2) Target domain

	Airbnb listing information in San Francisco, CA

(3) List of questions
	


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