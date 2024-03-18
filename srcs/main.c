#include "nm.h"

int main(int argc, char **argv){
    (void)argv;
    if (argc != 2){
        printf("nm: 'a.out': No such file\n");
        return (1);
    }
}