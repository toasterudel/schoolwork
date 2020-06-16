
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
