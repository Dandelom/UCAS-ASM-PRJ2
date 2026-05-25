#include <string.h>
#include "myhead.h"
#define BLOCKSIZE 4

extern void simd_block_transpose(float *m);

void simd_transpose(float *m)
{
    int blockNum = SIZE / BLOCKSIZE;
    float block[BLOCKSIZE * BLOCKSIZE] __attribute__((aligned(16)));

    for (int i = 0; i < blockNum; i++) {
        for (int r = 0; r < BLOCKSIZE; r++)
            memcpy(block + r * BLOCKSIZE,
                   m + (i * BLOCKSIZE + r) * SIZE + i * BLOCKSIZE,
                   BLOCKSIZE * sizeof(float));
        simd_block_transpose(block);
        for (int r = 0; r < BLOCKSIZE; r++)
            memcpy(m + (i * BLOCKSIZE + r) * SIZE + i * BLOCKSIZE,
                   block + r * BLOCKSIZE,
                   BLOCKSIZE * sizeof(float));

        for (int j = i + 1; j < blockNum; j++) {
            float block2[BLOCKSIZE * BLOCKSIZE] __attribute__((aligned(16)));
            for (int r = 0; r < BLOCKSIZE; r++) {
                memcpy(block + r * BLOCKSIZE,
                       m + (i * BLOCKSIZE + r) * SIZE + j * BLOCKSIZE,
                       BLOCKSIZE * sizeof(float));
                memcpy(block2 + r * BLOCKSIZE,
                       m + (j * BLOCKSIZE + r) * SIZE + i * BLOCKSIZE,
                       BLOCKSIZE * sizeof(float));
            }
            simd_block_transpose(block);
            simd_block_transpose(block2);
            for (int r = 0; r < BLOCKSIZE; r++) {
                memcpy(m + (j * BLOCKSIZE + r) * SIZE + i * BLOCKSIZE,
                       block + r * BLOCKSIZE,
                       BLOCKSIZE * sizeof(float));
                memcpy(m + (i * BLOCKSIZE + r) * SIZE + j * BLOCKSIZE,
                       block2 + r * BLOCKSIZE,
                       BLOCKSIZE * sizeof(float));
            }
        }
    }
}