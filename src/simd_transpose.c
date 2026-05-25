#include "myhead.h"
#define BLOCKSIZE 4

extern void simd_block_transpose(float *m, int row_stride);

void simd_transpose(float *m)
{
    int blockNum = SIZE / BLOCKSIZE;
    for (int i = 0; i < blockNum; i++)
    {
        for (int j = i; j < blockNum; j++)
        {
            float *block = m + i * BLOCKSIZE * SIZE + j * BLOCKSIZE;
            simd_block_transpose(block, SIZE);
        }
    }
    return;
}