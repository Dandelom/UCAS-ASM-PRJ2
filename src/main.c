#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define SIZE 4096

extern void simply_transpose(float *m);

int main()
{
    const char *inputFile="../tests/matrix_data.bin"; // test data
    const char *outputFile="../tests/output_data.bin"; // output data
    FILE *ifp=fopen(inputFile, "rb"); // read-noly, binary
    FILE *ofp=fopen(outputFile, "wb"); // write-noly, binary
    size_t elementNum=SIZE*SIZE;
    if(!ifp)
    {
        perror("Input file open failed.");
        return -1;
    }
    if(!ofp)
    {
        perror("Output file open failed.");
        return -1;
    }
    float *matrix=(float *)malloc(sizeof(float)*elementNum);
    fread(matrix, sizeof(float), elementNum, ifp);
    fclose(ifp);
    clock_t startTime, endTime; // stopwatch
    int number;
    printf("Please choose transpose method:\n");
    printf("1. Simply transpose\n");
    scanf("%d", &number);
    if(!(number >= 1 && number <= 1))
    {
        perror("Illgal input.");
        return -1;
    }
    
//  Please add your function below.

    startTime=clock();
    if(number == 1) simply_transpose(matrix);
    endTime=clock();
    double simplyTime=(double)(endTime-startTime)/CLOCKS_PER_SEC;
    printf("Simply transpose time:%.4f s\n", simplyTime);
    fwrite(matrix, sizeof(float), elementNum, ofp);
    fclose(ofp);
    printf("Output successfully.\n");

    free(matrix);
    return 0;
}