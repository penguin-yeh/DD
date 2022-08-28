
#include <stdio.h>
#include <stdlib.h>

int main()
{
    int i;
    for(i=0;i<16;i++)
    {
        printf("fulladder FA%d(a[%d], b[%d], c[%d], sum[%d], c[%d]\n",i+1,i,i,i-1,i,i);
    }
    return 0;
}