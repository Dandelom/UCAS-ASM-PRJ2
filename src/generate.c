#include <stdio.h>
#include <stdlib.h>
#define SIZE 4096

int main()
{
    const char *filename="../tests/matrix_data.bin";
    FILE *fp=fopen(filename, "wb"); // write, binary
    if(!fp)
    {
        perror("Create failed.");
        return -1;
    }
    float *row_buffer=(float *)malloc(SIZE*sizeof(float)); // write as row
    if(!row_buffer)
    {
        perror("Allocate failed.");
        fclose(fp);
        return -1;
    }
    for(int i=0; i<SIZE; i++)
    {
        for(int j=0; j<SIZE; j++)
            row_buffer[j]=(float)i+(float)j*0.0001f; // (57,32)=57.0032
        fwrite(row_buffer, sizeof(float), SIZE, fp);
    }
    free(row_buffer);
    fclose(fp);
    printf("Generate successfully.\n");
    return 0;
}