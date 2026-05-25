#include <stdio.h>
#include <stdlib.h>
#define SIZE 4096

int main()
{
    const char *inputFile="../tests/matrix_data.bin";
    const char *outputFile="../tests/output_data.bin";
    FILE *ifp=fopen(inputFile, "rb");
    FILE *ofp=fopen(outputFile, "rb");
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
    float *matrix1=(float *)malloc(sizeof(float)*elementNum);
    float *matrix2=(float *)malloc(sizeof(float)*elementNum);
    fread(matrix1, sizeof(float), elementNum, ifp);
    fread(matrix2, sizeof(float), elementNum, ofp);
    for(int i=0; i<SIZE; i++)
    {
        for(int j=0; j<SIZE; j++)
        {
            if(matrix1[i*SIZE+j] != matrix2[j*SIZE+i])
            {
                printf("Transpose mistakenly.");
                fclose(ifp);
                fclose(ofp);
                free(matrix1);
                free(matrix2);
                return 0;
            }
        }
    }
    printf("Transpose correctly.\n");
    fclose(ifp);
    fclose(ofp);
    free(matrix1);
    free(matrix2);
    return 0;
}