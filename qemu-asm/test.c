/*
 * Copyright 2025 Roger Piovet
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */

// Bogus global variables for debugging linker 
// script
struct struct_A
{
    int i0;
    int i1; 
    double d0;
    double d1;
} AA;

struct struct_A BB;
struct struct_A CC;
struct struct_A DD;

extern struct struct_A bar(int i0, int i1, double d0, double d1);

volatile double * w  = (volatile double*)0x0000000040080000; 
volatile double * w1 = (volatile double*)0x0000000040080000; 
volatile double * w2 = (volatile double*)0x0000000040080000; 
volatile double * w3 = (volatile double*)0x0000000040080000; 
volatile double * w4 = (volatile double*)0x0000000040080000; 

int main(void)
{
    // The following variables will be placed in .data
    volatile int x = 0;
    x = x + 1;
    volatile int y = 1; 
    y = y + 4;
    volatile double z = *w;

    // Call an assembly function from C code
    AA = bar(x, y, 1.0, z);

    //printf("AA.i0 = %d", A.i0);
    //printf("AA.i1 = %d", A.i1);
    //printf("AA.d0 = %lf", A.d0);
    //printf("AA.d1 = %lf", A.d1);
    return 0;
}
