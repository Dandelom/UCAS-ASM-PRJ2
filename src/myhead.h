#ifndef MYHEAD_H
#define MYHEAD_H
#define SIZE 4096

extern void simply_transpose(float *m); // 简单转置
void blockwise_transpose(float *m); // 分块转置
void simd_transpose(float *m); // 4x4 SIMD 转置
void avx_transpose(float *m); // 8x8 AVX 转置
void avx_prefetch(float *m); // AVX + prefetch

#endif