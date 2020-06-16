#   Christopher Rudel
#   Professor Dugas
#   CS 581 HW_9
#   fb_analysis.py
#
#   To run, enusre that you have you have matplotlib installed by running:
#   pip install matplotlib 
#   in terminal
#
#   After, ensure that you have the FB_data.csv file
#   from the assignment in the same directory and run:
#   python fb_analysis.py 
#   in terminal

import csv
import statistics as stats
import matplotlib.pyplot as plt

userids = []
ages = []
dob_months = []
dob_years = []
genders = []
tenures = []
friendship_counts = []
num_friendships_initiated = []
likes = []
likes_received = []
mobile_likes = []
mobile_likes_received = []
www_likes = []
www_likes_received = []

with open('FB_data.csv', newline='') as csvfile: # opens the file
    linereader = csv.reader(csvfile, delimiter=' ', quotechar='|')
    count = 0
    for row in linereader: # for each line in the file
        if(count == 0): # ignores the first line because it contains headers instead of numbers
            count = count + 1
            continue
        userid, age, dob_month, dob_day, dob_year, gender, tenure, friendship_count, friendships_initiated, likes_, likes_received_, mobile_likes_, mobile_likes_received_, www_likes_, www_likes_received_ = row[0].split(',')
        userids.append(int(userid))
        ages.append(int(age))
        dob_months.append(int(dob_month))
        dob_years.append(int(dob_year))
        genders.append(gender)
        try:
            tenures.append(int(tenure))
        except: # there are some entries in tenure that are 'NA' instead of a number
            tenures.append(0)
        friendship_counts.append(int(friendship_count))
        num_friendships_initiated.append(int(friendships_initiated))
        likes.append(int(likes_))
        likes_received.append(int(likes_received_))
        mobile_likes.append(int(mobile_likes_))
        mobile_likes_received.append(int(mobile_likes_received_))
        www_likes.append(int(www_likes_))
        www_likes_received.append(int(www_likes_received_))


# Plot 1
plot2 = plt.figure(1)
plt.scatter( friendship_counts, num_friendships_initiated)
plt.xlabel("Total Friendship Count")
plt.ylabel("Total Friendships Initiated")
plt.suptitle("Number of Initiated Friendships compared to Total Friendship Count")

print("\nMedian Total Friendship Count:\t\t", stats.median(friendship_counts))
print("Median Total Friendships Initiated\t", stats.median(num_friendships_initiated))

# Plot 2
plot3 = plt.figure(2)
plt.scatter(tenures, friendship_counts)
plt.xlabel("Number of Days on Facebook")
plt.ylabel("Friendship Count")
plt.suptitle("Number of Days on Facebook compared to Total Friendship Count")

print("\nMedian Number of Days on Facebook:\t", stats.median(tenures))
print("Median Total Friendship Count:\t\t", stats.median(friendship_counts))

# Plot 3
plot4 = plt.figure(3)
plt.scatter(friendship_counts, likes_received)
plt.xlabel("Friendship Count")
plt.ylabel("Likes Received")
plt.suptitle("Friendship Count compared to Amount of Likes Received")

print("\nMedian Total Friendship Count:\t\t", stats.median(friendship_counts))
print("Median Likes Received:\t\t\t", stats.median(likes_received))

# Plot 4

male_likes_received = []
female_likes_received = []
na_likes_received = []
count = 0
for person in genders:
    if(person == "male"):
        male_likes_received.append(likes_received[count])
    elif(person == "female"):
        female_likes_received.append(likes_received[count])
    else: # person == 'NA'
        na_likes_received.append(likes_received[count])
    count = count + 1

# I chose median over mean because median is not affected by skewed data points
m_median = stats.median(male_likes_received)
f_median = stats.median(female_likes_received)
na_median = stats.median(na_likes_received)

plot1 = plt.figure(4)
plt.bar(['Males', 'Females', 'NA'], [m_median, f_median, na_median])
plt.suptitle('Median Likes Received by Gender') 

print("\nMedian Likes Males Received:\t\t", m_median)
print("Median Likes Females Received:\t\t", f_median)
print("Median Likes 'NA' Received:\t\t", na_median)

# Plot 5

count = 0
year_data = {}
for year in dob_years:
    age = 2013 - year
    if age in year_data:
        year_data[age] = year_data[age] + [friendship_counts[count]]
    else:
        year_data[age] = [friendship_counts[count]]
    count = count + 1

age_keys = []
age_results = []

for age in year_data:
    age_keys.append(age)
    age_results.append(stats.median(year_data[age]))

plot5 = plt.figure(5)
plt.bar(age_keys, age_results)
plt.xlabel("User Age")
plt.ylabel("Median Number of Friends")
plt.suptitle("Median Number of Friends by Ages")

print("\nMedian User Age:\t\t\t", stats.median(age_keys))
print("Medain Number of Friends:\t\t", stats.median(age_results))

# Plot 6

count = 0
year_likes = {}
for year in dob_years:
    age = 2013-year
    if age in year_likes:
        year_likes[age] = year_likes[age] + [likes_received[count]]
    else:
        year_likes[age] = [likes_received[count]]
    count = count + 1

age_likes_keys = []
age_likes_results = []

for age in year_likes:
    age_likes_keys.append(age)
    age_likes_results.append(stats.median(year_likes[age]))

plot6 = plt.figure(6)
plt.bar(age_likes_keys, age_likes_results)
plt.xlabel("User Age")
plt.ylabel("Median Likes Received")
plt.suptitle("Median Likes Received by Age")

print("\nMedian User Age:\t\t\t", stats.median(age_likes_keys))
print("Median Likes Received:\t\t\t", stats.median(age_likes_results))

plt.show()
