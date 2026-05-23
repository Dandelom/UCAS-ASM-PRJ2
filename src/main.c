#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define SIZE 4096

// extern void simply_transpose(float *m);

int main()
{
    const char *filename="../tests/smatrix_data.bin"; // test data
    FILE *fp=fopen(filename, "rb"); // read-noly, binary
    size_t elementNum=SIZE*SIZE;
    if(!fp)
    {
        perror("File open failed.");
        return -1;
    }
    float *matrix=(float *)malloc(sizeof(float)*elementNum);
    fread(matrix, sizeof(float), elementNum, fp);
    fclose(fp);
    clock_t startTime, endTime; // stopwatch
/*
    Please add your function here.

    startTime=clock();
    simply_transpose(matrix);
    endTime=clock();
    double simplyTime=(endTime-startTime)/CLOCKS_PER_SEC;
    printf("Simply transpose time:%.4f s\n", simplyTime);

*/
    free(matrix);
    return 0;
}