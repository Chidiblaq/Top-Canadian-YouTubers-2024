/*
1. Define the variables.
2. Create a CTE that rounds the average views per video.
3. Select the columns that are required for the analysis.
4. Filter the results by the YouTube channels with the highest subscriber bases
5. Order by net_profit (descending)

*/

-- 1
DECLARE @conversion_rate FLOAT = 0.02   -- The conversion rate @ 2%
DECLARE @Product_cost MONEY = 5.0       -- The product cost @ $5 CAD
DECLARE @campaign_cost MONEY = 50000.0;  -- The campaign cost @$50000 CAD

-- 2
WITH ChannelData AS(
	SELECT
	channel_name,
	total_videos,
	total_views,
	ROUND((CAST(total_views AS FLOAT)/total_videos), -4) AS rounded_avg_views_per_video
	FROM youtube_db.dbo.view_Canada_Youtubers_2024
)

-- 3
SELECT 
	channel_name, 
	rounded_avg_views_per_video,
	(rounded_avg_views_per_video * @conversion_rate) as potential_units_sold_per_video,
	(rounded_avg_views_per_video * @conversion_rate * @Product_cost) as potential_revenue_per_video,
	(rounded_avg_views_per_video * @conversion_rate * @Product_cost) - @campaign_cost as net_profit
FROM ChannelData

-- 4
WHERE channel_name in ('Justin Bieber', 'Super Simple Songs - Kids Songs', 'The Weeknd', 'WatchMojo.com')

-- 5
ORDER BY net_profit DESC

