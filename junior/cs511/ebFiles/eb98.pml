byte semaphore;
byte tickets;
byte m;
byte w;
init{
	m = 0;
	w = 0;
	semaphore = 1;
	tickets = 0;
	byte count = 0;
}

// Taken from exercise 7
inline acquire(sem)
{
  atomic {
    sem>0;
    sem--;
  }
}

inline release(sem)
{
  sem++;
}

active [20] proctype woman(){
	atomic{
	release(tickets);
	w++;
	}
}

active [10] proctype man(){
	acquire(semaphore);
	acquire(tickets);
	acquire(tickets);
	m = m+1;
	release(semaphore);
	assert(m*2 <= w)
}


