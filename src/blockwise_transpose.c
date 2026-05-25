#include "myhead.h"
#define BLOCKSIZE 64

extern void diagonal_transpose(float *m);
extern void off_diagonal_transpose(float *m1, float *m2);

void blockwise_transpose(float *m)
{
    int blockNum=SIZE/BLOCKSIZE;
    int blockElem=BLOCKSIZE*BLOCKSIZE;
    for(int i=0; i<blockNum; i++)
    {
        for(int j=i; j<blockNum; j++)
        {
            if(i == j)
            {
                float *block=m+i*BLOCKSIZE*SIZE+j*BLOCKSIZE;
                diagonal_transpose(block);
            }
            else
            {
                float *block1=m+i*BLOCKSIZE*SIZE+j*BLOCKSIZE;
                float *block2=m+j*BLOCKSIZE*SIZE+i*BLOCKSIZE;
                off_diagonal_transpose(block1, block2);
            }
        }
    }
    return;
}