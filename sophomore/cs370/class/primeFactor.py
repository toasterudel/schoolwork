import time

startTime = time.time()

n = 600851475143 
k = 2
m = None
while n > 1:
  while n % k == 0:
    m = k
    n = n // k               # integer division
  k = k + 2 if k > 2 else 3  # 2, 3, 5, 7, 9, ...
print(m)
elapsedTime = time.time() - startTime
print(elapsedTime)
