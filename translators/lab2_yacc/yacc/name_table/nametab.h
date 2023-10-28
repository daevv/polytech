#ifndef __NAMETAB_H__
#define __NAMETAB_H__

/* if identical names can be stored in table, comment this '#define' */
#define REJECT_DUPLICATED_NAMES

struct namerec
{
    char *name;         
    struct namerec *next;   /* link field */
};

typedef struct namerec namerec;

namerec *lookup_name (char *);
int insert_name (char *);
int delete_name (char *);
void print_names (char *);

#endif

