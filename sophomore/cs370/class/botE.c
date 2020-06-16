#include <math.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <limits.h>
#include <stdbool.h>

int chiefHopper(int arr_size, int* arr) {
    int found = 0;
    int botEnergy=0;
    int counter = 0;
    while(!found)
    {
        int place = 0;
        while(botEnergy >=0)
        {
            if(arr[place] > botEnergy)
                botEnergy -= arr[place] - botEnergy;
            else{
                botEnergy += botEnergy - arr[place];
            }
            place++;
        }
        if(botEnergy >= 0)
            found++;
        else{
            counter++;
            botEnergy=counter;
        }
    }
    return botEnergy;
}

int main() {
    int n; 
    scanf("%i", &n);
    int *arr = malloc(sizeof(int) * n);
    for (int arr_i = 0; arr_i < n; arr_i++) {
       scanf("%i",&arr[arr_i]);
    }
    int result = chiefHopper(n, arr);
    printf("%d\n", result);
    return 0;
}
