/* Christopher Rudel */
#define N 5 /* number of processes in the ring */
#define L 10 /* size of buffer (>= 2*N) */
byte I; /* will be used in init for assigning ids to nodes */

mtype = { elect, winner }; /* symb. Msg. Names */
chan q[N] = [L] of { mtype , byte }; /* asynchronous channels */

proctype simplenode(chan inp, out; byte mynumber) {
  byte n;

  xr inp; 
  xs out; 

  out ! elect, mynumber; 
  do 
  :: inp ? elect,  n ->
        if 
        :: n == mynumber -> out ! winner, mynumber
           :: n < mynumber  -> out ! elect, mynumber
           :: n > mynumber  -> out ! elect, n
        fi
     :: inp ? winner, n ->
        if 
        :: n == mynumber -> printf("I am node %d and I know the leader is %d!\n", mynumber, n)
           :: n != mynumber -> printf("[%d] Node %d is the winner\n", mynumber, n);
                               out ! winner, n
        fi
  od
}

init {
  byte proc;
  byte Ini[6];
  atomic {
    I = 1;
    do
    :: I <= N ->
         if 
           :: Ini[0] == 0 && N >= 1 -> Ini[0] = I
           :: Ini[1] == 0 && N >= 2 -> Ini[1] = I
           :: Ini[2] == 0 && N >= 3 -> Ini[2] = I
           :: Ini[3] == 0 && N >= 4 -> Ini[3] = I
           :: Ini[4] == 0 && N >= 5 -> Ini[4] = I
           :: Ini[5] == 0 && N >= 6 -> Ini[5] = I
         fi;
         I++
      :: I > N -> 
         break
    od;

    proc = 1;
    do
    :: proc <= N ->
         run simplenode (q[proc -1], q[proc%N], Ini[proc -1]);
         proc++
    :: proc > N ->
         break
    od
  }
}