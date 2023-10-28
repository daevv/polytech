#include <time.h>

extern yyerror (char *);

/*
 *  Check date, abort on error.
 *  Returns no. of days since 1970-01-01
 */
long abs_date (int m, int d, int y)
{
    struct tm t;
    time_t seconds;


    t.tm_sec = t.tm_min = t.tm_hour = 0;

    t.tm_mday = d;    /* day of the month - [1,31] */
    t.tm_mon  = m;    /* months since January - [0,11] */
    y -= 1900;
    t.tm_year = y;    /* years since 1900, for <mktime> */

    if ((seconds = mktime(&t)) == (time_t)-1) {
        yyerror("Date is too far from 1970-01-01");   
        exit(1);
    }

    /* mktime turns wrong date like 32-th April to 2-nd May */
    /* (POSIX tells better avoid feeding mktime with that) */
    if (t.tm_mday != d || t.tm_mon != m || t.tm_year != y) {
        yyerror("Date is wrong (has been corrected)"); 
        exit(1);
    }
    return seconds / (3600L * 24L);
}

