# Top Influential Canadian YouTubers Analysis

![excel-to-powerbi-animated-diagram]()

# Table of contents
- [Overview](#Overview)
- [Problem Statement](#ProblemStatement)
- [Business Case](#BusinessCase)
- [Data Source](#DataSource)
- [Project Stages](#ProjectStages)
  - [Development](#Development)
    - [Data Exploration](#DataExploration)
    - [Data Cleaning](#DataCleaning)
  - [Testing](#Development)
  - [Visualization](#Development)
  - [Analysis](#Analysis)
  - [Recommendation](#Recommendation)
- [Tools Used](#ToolsUsed)
- [How to Use](#HowtoUse)

## Overview  
This data analysis project aims to identify and analyze the top influential Canadian YouTubers to facilitate marketing collaborations. The primary objective of the dashboard is to provide a comprehensive and user-friendly interface to discover the top-performing Canadian YouTubers.

## Problem Statement  
Marketers need a reliable and efficient way to identify top Canadian YouTubers to form successful marketing collaborations. This project addresses this need by providing a comprehensive analysis and user-friendly dashboard to highlight influential YouTubers based on key performance metrics.

## Business Case  
The dashboard provides valuable insights for marketing teams seeking to collaborate with top-performing Canadian YouTubers. By identifying key influencers based on subscriber count, views, and engagement metrics, marketers can make data-driven decisions to optimize their influencer partnerships.

## Data Source  
- Kaggle: Initial dataset. https://www.kaggle.com/datasets/bhavyadhingra00020/top-100-social-media-influencers-2024-countrywise  
- YouTube API: Python script to gather additional data (Total Subscribers, Total Videos, and Total Views).  

## Project Stages 
- Development
- Testing
- Visualization
- Analysis
- Recommendation

## Development  
Get the Data: Retrieve datasets from Kaggle and YouTube API.  
Explore the Data: Preliminary analysis in Excel to identify errors, inconsistencies, and data structure.  
Load the Data: Import the data into MS SQL Server.  
Clean the Data: Refine the dataset to ensure it is structured and ready for analysis.  
Test the Data: Perform data quality and validation checks.  
Visualize the Data: Import cleaned data into Power BI and create visualizations.  
Generate Findings: Analyze insights using Excel.  
Write Documentation: Document the entire process and findings.  
Publish Data: Share the final product on GitHub Pages.  

### Data Exploration  
The dataset was scanned for errors, inconsistencies, bugs, and corrupted characters.  
Verified that the required columns contain the necessary data for analysis.     

### Data Cleaning  
Removed unnecessary columns to streamline the dataset.  
Extracted channel names from the first column using channel IDs. 
Ensured all data types are appropriate for their respective columns.  
Created an SQL view for use in Power BI.  

```sql

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

```


## Testing  
Conducted data quality and validation checks, including:  
- Row count check  
- Column count check  
- Data type checks  
- Duplicate check  
``` sql

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

```


## Visualization  
Imported data into Power BI.  
Created DAX measures and visualizations (Tree Map, Table, Bar Charts, and Cards).  
Created visuals to display key metrics: Total Subscribers, Total Views, Average Views, Total Videos, and Subscriber Engagement Rates.  
![TopCanadianYoutubers]()

## Analysis  
Addressed these key questions for marketing clients:  
1. Who are the top 10 YouTubers with the most subscribers?  
2. Which 3 channels have uploaded the most videos?  
3. Which 3 channels have the most views?  
4. Which 3 channels have the highest average views per video?  
5. Which 3 channels have the highest views per subscriber ratio?  
6. Which 3 channels have the highest subscriber engagement rate per video uploaded?  

## Recommendations:
Although one will argue that "Super Simple Songs - Kids Songs" (SSS) has more views in total (50.94 billion) with 792 videos made so it is clearly the best channel to partner with but in reality, the channel is actually performing poorly when you compare the average view per video(~ 64 million) with other top 3 channels (Justin Bieber - 129 million) and (The Weeknd - 159 million). On further deep down analysis, the ROI using the average view per video, I would recommend partnering with "The Weeknd" and/or "Justin Bieber" because it makes more business sense when comparing the Return on Investment.


## Tools Used:  
- Excel: Data exploration and initial analysis.  
- MS SQL Server: Data storage and cleaning.  
- Power BI: Data visualization.  
- Python Script: Data collection from YouTube API.  


## How to Use:  
- Clone the repository.  
- Follow the setup instructions in the documentation.  
- Use the provided Power BI dashboard to explore insights and findings.


This README provides an overview of the project, detailing each stage and providing essential information for users to understand the objectives, processes, and outcomes of the analysis.
