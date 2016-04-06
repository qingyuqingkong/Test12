//
//  main.m
//  Test
//
//  Created by AIogle on 16/3/16.
//  Copyright © 2016年 AIogle. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

static void f();
static void g();
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        g();
        
        f();
        
        
    }
    return 0;
}

void g(){
    int i[20];
    i[0] = 0;
    i[1] = 1;
    i[2] = 1;
    for (int a = 3; a < 20; a ++) {
        i[a] = i[a - 1] + i[a - 2] + i[a - 3];
        //printf("i[%d]=%d\n",a,i[a]);
    }
    printf("第二是项=%d",i[19]);
}

void f(){
    int i1[20],i2[20],i3[20];
    //srand(unsigned)time(NULL);
    
}













