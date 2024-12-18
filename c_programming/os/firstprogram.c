#include<stdio.h>
#include<sys/types.h>
#include<unistd.h>

int main(){
    fork();
    printf("Hello world how are you!\n");
    fork();
    printf("hello guus\n");
    return 0;
}