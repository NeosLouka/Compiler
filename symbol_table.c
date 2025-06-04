#include "symbol_table.h"
#include <stdlib.h>
#include <string.h>

static struct symbol *sym_table = NULL;

struct symbol *sym_lookup(const char *name) {
    for (struct symbol *p = sym_table; p; p = p->next) {
        if (strcmp(p->name, name) == 0) {
            return p;
        }
    }
    struct symbol *sym = malloc(sizeof(struct symbol));
    sym->name = strdup(name);
    sym->value = 0;
    sym->next = sym_table;
    sym_table = sym;
    return sym;
}

void sym_free_all(void) {
    struct symbol *p = sym_table;
    while (p) {
        struct symbol *next = p->next;
        free(p->name);
        free(p);
        p = next;
    }
    sym_table = NULL;
}
