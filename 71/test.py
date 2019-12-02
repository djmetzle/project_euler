def farey_function(n, descending=False):
    """Print the nth Farey sequence, either ascending or descending."""
    a, b, c, d = 0, 1, 1, n
    if descending: 
        a, c = 1, n-1
    print "%d/%d" % (a,b)
    while (c <= n and not descending) or (a > 0 and descending):
        print "LOOP: %d %d %d %d" % (a,b,c,d)
        val = (n + b) / d
        print "VAL: %f" % val
        k = int((n + b) / d)
        print "K: %d" % k
        a, b, c, d = c, d, (k*c-a), (k*d-b)
        print "ITER: %d/%d \n" % (a,b)

farey_function(8)
