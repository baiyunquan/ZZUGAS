long arith2(long x, long y, long z)
{
    /* $begin 090-arith-prob-solve-c */
    long t1 = x | y;
    long t2 = t1 >> 3;
    long t3 = ~t2;
    long t4 = z - t3;
    /* $end 090-arith-prob-solve-c */
    return t4;
}