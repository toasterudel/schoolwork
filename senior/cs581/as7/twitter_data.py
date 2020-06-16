# Christopher Rudel
# Professor Dugas
# CS 581WS
# Assignment07
# twitter_data.py
#
#
# To run this file, run this command in terminal: 
# python3 twitter_data.py
# The program will ask you to Input the desired twitter user until you enter STOP

# The goal of this script is to retrieve the twitter data of the user input

import tweepy

### PUT AUTHENTICATOIN KEYS HERE ###
CONSUMER_KEY = "XG4uQKfPqNDt4SGoIY5eUtXir"
CONSUMER_KEY_SECRET = "wRHARkLe3FpfpPxmENp3772WfZEj6HnY6rjxN0izdaSeRL6K7y"
ACCESS_TOKEN = "2290525592-CxCGiUrYR41VMGndGoyQzQxFq29rK6aczow9DvL"
ACCESS_TOKEN_SECRET = "h864APMmkjpvnClN340JwlB9PB4C4KlyM4wCBb3P8QXZr"

# Authentication

authenticate = tweepy.OAuthHandler(CONSUMER_KEY, CONSUMER_KEY_SECRET)
authenticate.set_access_token(ACCESS_TOKEN, ACCESS_TOKEN_SECRET)

#  use wait_on_rate_limit to avoid going over Twitter's rate limits
api = tweepy.API(authenticate, wait_on_rate_limit=True, 
                 wait_on_rate_limit_notify=True)
                 
# Get Information About a Twitter User Account

# twitter_user = api.get_user('FollowStevens')

# # Get Basic Account Information
# print("twitter_user id: ", twitter_user.id)

# print("twitter_user name: ", twitter_user.name)

# # Determine an Account’s Friends 
# friends = []

# print("\nFirst 5 friends:")

# # Creating a Cursor
# cursor = tweepy.Cursor(api.friends, screen_name='FollowStevens')

# # Get and print 5 friends
# for account in cursor.items(5):
#     print(account.screen_name)

#############################  Above was given by professor  ###################################
    
while True: #program is designed to run forever until user enters "STOP"
    userInput = input("Enter Twitter User Screen Name:")
    if (userInput == "STOP"): #stops program 
        print("Stopping...")
        break
    else:
        try:
            twitterUser = api.get_user(userInput) #get user information
            #printing user information 
            print(userInput + "'s statistics:")
            print("Name:\t\t\t", twitterUser.name) 
            print("User Scren Name:\t", twitterUser.screen_name)
            print("User ID:\t\t", twitterUser.id)
            print("User description:\t", twitterUser.description)
            print("Number of followers:\t", twitterUser.followers_count)
            last_tweet = api.user_timeline(id = twitterUser.id, count=1)[0] #get most recent tweet
            #taken from https://stackoverflow.com/questions/32022845/get-the-last-tweet-with-tweepy
            print("Most recent tweet:\t", last_tweet.text)
            cursor = tweepy.Cursor(api.friends, screen_name=twitterUser.screen_name) #given in original code
            print("First 10 followers:")
            for account in cursor.items(10):
                print("\t\t\t",account.screen_name)
        except Exception as e: print("ERROR!:\t\t\t", e) # I have this here because if the user hasn't tweeted anything it will error

