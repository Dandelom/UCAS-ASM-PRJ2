#include <string.h>
#include "myhead.h"
#define BLOCKSIZE 8

extern void avx_block_transpose(float *m);

void avx_transpose(float *m)
{
    int blockNum = SIZE / BLOCKSIZE;
    float block[BLOCKSIZE * BLOCKSIZE];

    for (int i = 0; i < blockNum; i++) {
        for (int j = 0; j < blockNum; j++) {
            if (i < j) {
                for (int r = 0; r < BLOCKSIZE; r++) {
                    memcpy(block + r * BLOCKSIZE,
                           m + (i * BLOCKSIZE + r) * SIZE + j * BLOCKSIZE,
                           BLOCKSIZE * sizeof(float));
                }
                avx_block_transpose(block);

                float block2[BLOCKSIZE * BLOCKSIZE];
                for (int r = 0; r < BLOCKSIZE; r++) {
                    memcpy(block2 + r * BLOCKSIZE,
                           m + (j * BLOCKSIZE + r) * SIZE + i * BLOCKSIZE,
                           BLOCKSIZE * sizeof(float));
                }
                avx_block_transpose(block2);

                for (int r = 0; r < BLOCKSIZE; r++) {
                    memcpy(m + (j * BLOCKSIZE + r) * SIZE + i * BLOCKSIZE,
                           block + r * BLOCKSIZE,
                           BLOCKSIZE * sizeof(float));
                    memcpy(m + (i * BLOCKSIZE + r) * SIZE + j * BLOCKSIZE,
                           block2 + r * BLOCKSIZE,
                           BLOCKSIZE * sizeof(float));
                }
            } else if (i == j) {
                for (int r = 0; r < BLOCKSIZE; r++) {
                    memcpy(block + r * BLOCKSIZE,
                           m + (i * BLOCKSIZE + r) * SIZE + i * BLOCKSIZE,
                           BLOCKSIZE * sizeof(float));
                }
                avx_block_transpose(block);
                for (int r = 0; r < BLOCKSIZE; r++) {
                    memcpy(m + (i * BLOCKSIZE + r) * SIZE + i * BLOCKSIZE,
                           block + r * BLOCKSIZE,
                           BLOCKSIZE * sizeof(float));
                }
            }
        }
    }
}