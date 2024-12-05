// Compile: gcc -o problem1_1 problem1.c -zexecstack
#include <unistd.h>
#include <stdio.h>
#include <string.h>

void func1(char *buf) {
    read(0, buf, 255); 
}

void func2(char *buf) {
    printf("%s\n", buf);
}

void func3() {
    printf("GOODLUCKISO14229-1!\n");
}

int main(void) {
    char buf[256];
    char sel;

    setvbuf(stdin, 0, 2, 0);
    setvbuf(stdout, 0, 2, 0);
    
    memset(buf, 0, 256);

    while (1) {
        write(1, ">>> ", 4);
        scanf(" %c", &sel); 
        
        switch (sel) {
            case 'M':
                func1(buf);
                break;
            case 'O':
                func2(buf);
                break;
            case 'S':
                return 0;
                break;
            case 'E':
                func3();
                break;
        }
    }

    return 0;
}

