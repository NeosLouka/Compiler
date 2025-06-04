#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

struct symbol {
    char *name;
    int value;
    struct symbol *next;
};

struct symbol *sym_lookup(const char *name);
void sym_free_all(void);

#endif /* SYMBOL_TABLE_H */
