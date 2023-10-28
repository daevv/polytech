#include <stdio.h>
#include <string.h>

#include "nametab.h"

static namerec *name_table = (namerec *)0;

/*
 *  Returns pointer to namerec, if name is found.
 *  Otherwise returns 0-pointer.
 */
namerec *lookup_name (char *s)
{
    namerec *p;

        
    for (p = name_table; p; p = p->next)
        if (strcmp(p->name, s) == 0)
            break;
    return p;           /* if not found, p = 0 */
}

int insert_name (char *s)
{
    namerec *p;

    
#ifdef REJECT_DUPLICATED_NAMES
    if (lookup_name(s)) /* check if the name already inserted */
        return 0;
#endif
    p           = (namerec *) malloc(sizeof(namerec));
    p->name     = strdup(s);
    p->next     = name_table;
    name_table  = p;
    return 1;
}

int delete_name (char *s)
{
    namerec *p, *q;
    
    
    for (p = q = name_table; p; q = p, p = p->next)
        if (strcmp(p->name, s) == 0)
            break;
    if (!p) 
        return 0;

    free(p->name); 
    if (p == name_table) 
        name_table = p->next;
    else
        q->next = p->next;
    free(p);

    return 1;
}

void print_names (char *header)
{
    namerec *p;


    fprintf(stderr, "%s", header);
    for (p = name_table; p; p = p->next)
        fprintf(stderr, "%s\n", p->name);
}

