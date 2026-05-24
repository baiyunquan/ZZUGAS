/* eg0401.c*/
long exchange(long *xp, long y)
{
    long x = *xp;
    *xp = y;
    
    return x;
}


long long exchangell(long long *xp, long long y)
{
    long long x = *xp;
    *xp = y;
    
    return x;
}
