#include "myhead.h"
#define BLOCKSIZE 8

extern void avx_prefetch_transpose(float *m_block, int size, float *next_block);

extern void avx_dual_prefetch_transpose(float *blockA, float *blockB, int size, float *next_block);

void avx_prefetch(float *m)
{
    int blockNum=SIZE/BLOCKSIZE;
    for(int i=0; i<blockNum; i++)
    {
        for(int j=0; j<blockNum; j++)
        {
            float *next_block_ptr;
            if(j+1 < blockNum)
                next_block_ptr=m+(i*BLOCKSIZE)*SIZE+(j+1)*BLOCKSIZE;
            else if(i+1<blockNum)
                next_block_ptr=m+((i+1)*BLOCKSIZE)*SIZE;
            else
                next_block_ptr=m+(i*BLOCKSIZE)*SIZE+j*BLOCKSIZE;
            if(i < j)
            {
                float *blockA=m+(i*BLOCKSIZE)*SIZE+j*BLOCKSIZE;
                float *blockB=m+(j*BLOCKSIZE)*SIZE+i*BLOCKSIZE;
                avx_dual_prefetch_transpose(blockA, blockB, SIZE, next_block_ptr);
            } 
            else if (i == j)
            {
                float *blockDiag=m+(i*BLOCKSIZE)*SIZE+i*BLOCKSIZE;
                avx_prefetch_transpose(blockDiag, SIZE, next_block_ptr);
            }
        }
    }
}