import os
import pandas as pd
from dotenv import load_dotenv
from googleapiclient.discovery import build

# Load environment variables from .env file
load_dotenv() 

# Get the API key from environment variables
API_KEY = "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
API_VERSION = 'v3'

# Build the YouTube service object
youtube = build('youtube', API_VERSION, developerKey=API_KEY)

def get_channel_stats(youtube, channel_id):
    try:
        request = youtube.channels().list(
            part='snippet, statistics',
            id=channel_id
        )
        response = request.execute()

        if response['items']:

            data = dict(channel_name=response['items'][0]['snippet']['title'],
                        total_subscribers=response['items'][0]['statistics']['subscriberCount'],
                        total_views=response['items'][0]['statistics']['viewCount'],
                        total_videos=response['items'][0]['statistics']['videoCount'],
            )

            return data
        else:
            return None
    except Exception as e:
        print(f"An error occurred: {e}")
        return None


# channel_id = "UC_aEa8K-EOJ3D6gOs7HcyNg" 
channel_id = "UC9LQwHZoucFT94I2h6JOcjw"
get_channel_stats(youtube, channel_id)

# Read CSV into dataframe 
df_us = pd.read_csv("youtube_data_united-states.csv")
#df_canada = pd.read_csv("youtube_data_canada.csv")


# Extract channel IDs and remove potential duplicates
us_channel_ids = df_us['NAME'].str.split('@').str[-1].unique()
#canada_channel_ids = df_canada['NAME'].str.split('@').str[-1].unique()


# Initialize a list to keep track of channel stats
us_channel_stats = []
#canada_channel_stats = []


# Loop over US channel IDs and get stats for each
for channel_id in us_channel_ids:
    stats = get_channel_stats(youtube, channel_id)
    if stats is not None:
        us_channel_stats.append(stats)

# Loop over Canada channel IDs and get stats for each
# for channel_id in canada_channel_ids:
#     stats = get_channel_stats(youtube, channel_id)
#     if stats is not None:
#         canada_channel_stats.append(stats)


# Convert stats to dataframes if needed
df_us_stats = pd.DataFrame(us_channel_stats)
#df_canada_stats = pd.DataFrame(canada_channel_stats)


df_us.reset_index(drop=True, inplace=True)
df_us_stats.reset_index(drop=True, inplace=True)

# df_canada.reset_index(drop=True, inplace=True)
# df_canada_stats.reset_index(drop=True, inplace=True)


# Concatenate the dataframes horizontally
us_combined_df = pd.concat([df_us, df_us_stats], axis=1)
#canada_combined_df = pd.concat([df_canada, df_canada_stats], axis=1)


# Drop the 'channel_name' column from stats_df (since 'NOMBRE' already exists)
# combined_df.drop('channel_name', axis=1, inplace=True)


# Save the merged dataframe back into a CSV file
us_combined_df.to_csv('updated_youtube_data_us.csv', index=False)
#canada_combined_df.to_csv('updated_youtube_data_canada.csv', index=False)


print(us_combined_df.head(10))
#print(canada_combined_df.head(10))
