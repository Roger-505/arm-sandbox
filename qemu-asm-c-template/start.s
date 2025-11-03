/*
 * Copyright 2020, 2025 Francesco Balducci, Roger Piovet
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

.text

.global _start

_start:
	/* set stack */
	ldr x1, =stack_top
	mov sp, x1

    /* load linker constants */
    ldr x0,=_data_load_start
    ldr x1,=_data_load_end
    ldr x2,=_data
    ldr x3,=_bss
    ldr x4,=_ebss

    /* copy .data from LMA to VMA */
copy_data:
    ldrb w5,[x0], #1
    strb w5,[x2], #1
    cmp x1, x0
    bge copy_data

    /* zero-out .bss section */
zero_bss:
    strb wzr,[x3], #1
    cmp x4,x3
    bge zero_bss

	/* jump to main */
	bl main 
    b .
