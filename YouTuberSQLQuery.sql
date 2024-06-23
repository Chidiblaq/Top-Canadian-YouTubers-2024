/*
Data Cleaning steps

1. Remove the unnecessary columns and keep the important columns
2. Extract the Youtube channel names from the first columns

*/
select
	Name,
	total_subscribers,
	total_views,
	total_videos
from 
	top_canada_youtubers_2024

-- Let's extract the channel name from the Name column.
-- CHARINDEX
SELECT CHARINDEX('@', NAME) AS Position, NAME
	FROM top_canada_youtubers_2024

CREATE VIEW view_Canada_Youtubers_2024 AS

-- Using a substring
SELECT CAST(SUBSTRING(NAME, 1, CHARINDEX('@', NAME) -1) AS varchar(100)) AS channel_name,
	total_subscribers,
	total_views,
	total_videos
	FROM top_canada_youtubers_2024


/*
Data Quality Tests

1. The data needs to be 100 records of YouTube channels (row count test)
2. The data needs 4 fields(column count test)
3. The channel must be string format and the other columns must be numerical data types(data type check)
4. Each record must be unique in the dataset(duplicate check)

Row count = 100
Column count = 4

Channel_name = VARCHAR
total_subscribers = INTEGER
total_views = INTEGER
total_videos = INTEGER

Duplicate Count = 0

*/

-- Row count check

SELECT COUNT(*) from view_Canada_Youtubers_2024

-- Column count check
SELECT COUNT(*) AS column_count 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'view_Canada_Youtubers_2024'

-- Data Type Check
SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'view_Canada_Youtubers_2024'

-- Duplicate record check

SELECT channel_name, COUNT(*) as duplicate_count
from view_Canada_Youtubers_2024
group by channel_name
having count(*) > 1