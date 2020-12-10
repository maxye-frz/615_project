/*neighborhood COVID data, cumulative_cases data through 12/4/2020, new_cases data between 11/5/2020 and 12/4/2020*/
/*create table and insert data*/
DROP TABLE COVID_DATA;

CREATE TABLE COVID_DATA (
	neighborhood varchar(50) NOT NULL,
	resident_population INTEGER DEFAULT 0 NOT NULL,
	cumulative_cases INTEGER,
	new_cases INTEGER,
	PRIMARY KEY (neighborhood)
	);

INSERT INTO COVID_DATA VALUES 
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

ALTER TABLE COVID_DATA 
ADD COLUMN Rate_of_cases_per_10000 DECIMAL(6, 2)
AFTER cumulative_cases;

UPDATE COVID_DATA 
SET Rate_of_cases_per_10000 = cumulative_cases/(resident_population/10000);

ALTER TABLE COVID_DATA
ADD COLUMN Rate_of_new_cases_per_10000 DECIMAL(6, 2)
AFTER new_cases;

UPDATE COVID_DATA 
SET Rate_of_new_cases_per_10000 = new_cases/(resident_population/10000);


