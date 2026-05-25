#include "myhead.h"
#define BLOCKSIZE 8

extern void avx_block_transpose(float *m, int row_stride);

void avx_transpose(float *m)
{
    int blockNum = SIZE / BLOCKSIZE;
    for (int i = 0; i < blockNum; i++)
    {
        for (int j = i; j < blockNum; j++)
        {
            float *block = m + i * BLOCKSIZE * SIZE + j * BLOCKSIZE;
            avx_block_transpose(block, SIZE);
        }
    }
    return;
}