# Author:  Christopher Rudel
#           The "youtube_search" function was written by Cheryl Dugas, assignment specified we were allowed to incorporate provided materials
#  CS 581 Online Social Networks
#  youtube_data.py searches YouTube for videos matching a search term with a provided maximum amount of search values

# To run from terminal window:   python3 youtube_data.py 
#                                the program will prompt you to input your search term
#                                and the max number of values you want

from googleapiclient.discovery import build # use build function to create a service object

import unidecode   #  need for processing text fields in the search results
import csv

# put your API key into the API_KEY field below, in quotes
API_KEY = "AIzaSyBO5yrWJ2QNEqxKzoW5mTgZ6_4a5Xf7tNE"

API_NAME = "youtube"
API_VERSION = "v3"       # this should be the latest version

videos = []
highestViews = []

#  function youtube_search retrieves the YouTube records

def youtube_search(s_term, s_max):
    youtube = build(API_NAME, API_VERSION, developerKey=API_KEY)

    search_response = youtube.search().list(q=s_term, part="id,snippet", maxResults=s_max).execute()
    print("Search Term: " + s_term)
    print("Maximum Search Results: " + str(s_max))
    
    # search for videos matching search term;
    i=0
    for search_result in search_response.get("items", []):
        if search_result["id"]["kind"] == "youtube#video":
            title = search_result["snippet"]["title"]
            title = unidecode.unidecode(title)  
            videoId = search_result["id"]["videoId"]
            video_response = youtube.videos().list(id=videoId,part="statistics").execute()
            for video_results in video_response.get("items",[]):
                viewCount = video_results["statistics"]["viewCount"]
                if 'likeCount' not in video_results["statistics"]:
                    likeCount = 0
                else:
                    likeCount = video_results["statistics"]["likeCount"]
                if 'dislikeCount' not in video_results["statistics"]:
                    dislikeCount = 0
                else:
                    dislikeCount = video_results["statistics"]["dislikeCount"]
                if 'commentCount' not in video_results["statistics"]:
                    commentCount = 0
                else:
                    commentCount = video_results["statistics"]["commentCount"]
            
            #print("")    
            #print("Result #" + str(i+1) + ": " + title,videoId,viewCount,likeCount,dislikeCount,commentCount)
            # the assignment did not say to output the search to console
            videos.append({'Video Title': title, 'VideoID': videoId, 'ViewCount': int(viewCount), 'LikeCount': int(likeCount), 'DislikeCount': int(dislikeCount), 'CommentCount': int(commentCount)})
            i = i+1

def video_analysis():
    # I found how to do sorting like this here: https://stackoverflow.com/questions/72899/how-do-i-sort-a-list-of-dictionaries-by-a-value-of-the-dictionary
    # assignment asked for highest views, highest like percentage, and highest dislike percentage

    print("\n******** Analysis Below ********")
    highestViews = sorted(videos, key=lambda k: k['ViewCount'], reverse = True)
    i=0
    print("\nHeighest Views: ")
    for video in highestViews:
        if i > 4: # This is to only display 5 results
            break
        print("Rank " + str(i+1) + ": " + video['Video Title'] + ", ID: " + str(video['VideoID']) + ", Views: " + str(video['ViewCount']))
        i = i+1
    
    likePercentage = sorted(videos, key=lambda k: k['LikeCount'] / k['ViewCount'], reverse = True)
    j=0
    print("\nHighest Like Percentage: ")
    for video in likePercentage:
        if j > 4:
            break
        print("Rank " + str(j+1) + ": " + video['Video Title'] + ", ID: " + str(video['VideoID']) + ", Like Percentage: " + str( round( video['LikeCount'] / video['ViewCount'] * 100 , 2 )) + "%")
        j = j+1

    dislikePercentage = sorted(videos, key=lambda k: k['DislikeCount'] / k['ViewCount'], reverse = True)
    k=0
    print("\nHighest Dislike Percentage: ")
    for video in dislikePercentage:
        if k > 4:
            break
        print("Rank " + str(k+1) + ": " + video['Video Title'] + ", ID: " + str(video['VideoID']) + ", Dislike Percentage: " + str( round( video['DislikeCount'] / video['ViewCount'] * 100 , 2 )) + "%")
        k = k+1


# Function that writes results to a csv file. It appends to the file, so if it already exists it will append to the existing file.
def writeToFile():
    with open('Results.csv', 'a', newline='') as csvfile:
        fieldnames = ['Video Title', 'VideoID', 'ViewCount', 'LikeCount', 'DislikeCount', 'CommentCount', 'LikePercentage', 'DislikePercentage']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        for video in videos:
            writer.writerow({'Video Title': video['Video Title'], 'VideoID': video['VideoID'], 'ViewCount': video['ViewCount'], 'LikeCount': video['LikeCount'], 'DislikeCount': video['DislikeCount'], 'CommentCount': video['CommentCount'], 'LikePercentage': str( round( video['LikeCount'] / video['ViewCount'] * 100, 2 )) + "%" , 'DislikePercentage': str( round( video['DislikeCount'] / video['ViewCount'] * 100 , 2 )) + "%"})

# main routine

search_term = input("Enter your search term: ")
search_max_str = input("Enter the maximum number of results: ")
search_max = int(search_max_str)
youtube_search(search_term, search_max)
video_analysis()
writeToFile()
