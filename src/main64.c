#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "myhead.h"
#define SIZE 4096

int main()
{
    const char *inputFile="../tests/matrix_data.bin";
    const char *outputFile="../tests/output_data.bin";
    FILE *ifp=fopen(inputFile, "rb");
    FILE *ofp=fopen(outputFile, "wb");
    size_t elementNum=SIZE*SIZE;
    
    if(!ifp) { perror("Input file open failed."); return -1; }
    if(!ofp) { perror("Output file open failed."); return -1; }
    
    float *matrix=(float *)malloc(sizeof(float)*elementNum);
    fread(matrix, sizeof(float), elementNum, ifp);
    fclose(ifp);
    
    clock_t startTime, endTime;
    int number;
    
    printf("Please choose transpose method:\n");
    printf("3. 4x4 SIMD transpose\n");
    printf("4. 8x8 AVX transpose\n");
    printf("5. AVX + prefetch transpose\n");
    scanf("%d", &number);
    
    if(!(number == 3 || number == 4 || number == 5)) { perror("Illegal input."); return -1; }
    
    startTime=clock();
    if(number == 3) simd_transpose(matrix);
    else if(number == 4) avx_transpose(matrix);
    else if(number == 5) avx_prefetch(matrix);
    endTime=clock();
    
    double t=(double)(endTime-startTime)/CLOCKS_PER_SEC;
    printf("Time:%f s\n", t);
    
    fwrite(matrix, sizeof(float), elementNum, ofp);
    fclose(ofp);
    printf("Output successfully.\n");
    
    free(matrix);
    return 0;
}