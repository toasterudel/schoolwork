import pandas as pd
import random
import time
import math
import csv

# define move set
MOVES = [0, 1, 2]
# define area
BOUND_X_MIN = 0
BOUND_Y_MIN = 0
BOUND_X_MAX = 100
BOUND_Y_MAX = 100


def print_state(person):
    print("%d is at (%d,%d) and is %ssick" %
          (person.id, person.x, person.y, "" if person.is_sick else "not "))

# define class person with position


class Person:
    def __init__(self, id, pos_x, pos_y):
        self.id = id
        self.x = pos_x
        self.y = pos_y
        self.is_sick = False
        self.goto_x = random.randrange(BOUND_X_MAX)
        self.goto_y = random.randrange(BOUND_Y_MAX)

    def move(self):
        # random move set, if at edge, then do nothing
        if(self.x == self.goto_x and self.y == self.goto_y):
            # set new random coords if arrived at destination
            self.goto_x = random.randrange(BOUND_X_MAX)
            self.goto_y = random.randrange(BOUND_Y_MAX)
        elif(self.x == self.goto_x):
            self.y += 1
        elif(self.y == self.goto_y):
            self.x += 1
        else:
            move = random.choice(MOVES)
            if(move == 0):
                if ((self.goto_x - self.x) > 0):
                    self.x += 1
                else:
                    self.x -= 1
            elif(move == 1):
                if ((self.goto_y - self.y) > 0):
                    self.y += 1
                else:
                    self.y -= 1


# calculate manhattan distance abs(posx - posx)
def within_area(person1, person2, prox):
    if(abs(person1.x-person2.x) <= prox and abs(person1.y-person2.y) <= prox):
        return True
    else:
        return False


def main():
    with open('vals.csv', 'w', newline='') as csvfile:
        fieldNames = ['day', 'Person 0', 'Person 1', 'Person 2', 'Person 3', 'Person 4', 'Person 5', 'Person 6', 'Person 7', 'Person 8', 'Person 9', 'Person 10',
                      'Person 11', 'Person 12', 'Person 13', 'Person 14', 'Person 15', 'Person 16', 'Person 17', 'Person 18', 'Person 19', 'Person 20',
                      'Person 21', 'Person 22', 'Person 23', 'Person 24', 'Person 25', 'Person 26', 'Person 27', 'Person 28', 'Person 29']
        writer = csv.DictWriter(csvfile, fieldNames)
        writer.writeheader()

        arr = []
        for i in range(30):
            arr.append(Person(i, 0, i*2))
            print_state(arr[i])
            # create a bunch of classes
        # make one person sick
        arr[0].is_sick = True

        for time_step in range(400):
            for i in range(30):
                arr[i].move()
            # can optimize this part
            for lol in range(30):
                for gey in range(30):
                    if(lol != gey):
                        if(within_area(arr[lol], arr[gey], 1)):
                            if(arr[lol].is_sick or arr[gey].is_sick):
                                arr[lol].is_sick = True
                                arr[gey].is_sick = True
            # print out states
            writer.writerow({'day': 'day ' + str(time_step), 'Person 0': arr[0].is_sick, 'Person 1': arr[1].is_sick, 'Person 2': arr[2].is_sick,
                             'Person 3': arr[3].is_sick, 'Person 4': arr[4].is_sick, 'Person 5': arr[5].is_sick, 'Person 6': arr[6].is_sick,
                             'Person 7': arr[7].is_sick, 'Person 8': arr[8].is_sick, 'Person 9': arr[9].is_sick, 'Person 10': arr[10].is_sick,
                             'Person 11': arr[11].is_sick, 'Person 12': arr[12].is_sick, 'Person 13': arr[13].is_sick, 'Person 14': arr[14].is_sick,
                             'Person 15': arr[15].is_sick, 'Person 16': arr[16].is_sick, 'Person 17': arr[17].is_sick, 'Person 18': arr[18].is_sick,
                             'Person 19': arr[19].is_sick, 'Person 20': arr[20].is_sick, 'Person 21': arr[21].is_sick, 'Person 22': arr[22].is_sick,
                             'Person 23': arr[23].is_sick, 'Person 24': arr[24].is_sick, 'Person 25': arr[25].is_sick, 'Person 26': arr[26].is_sick,
                             'Person 27': arr[27].is_sick, 'Person 28': arr[28].is_sick, 'Person 29': arr[29].is_sick, })
        return arr


main()
