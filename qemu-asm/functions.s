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

// Based on https://cs140e.sergio.bz/docs/ARMv8-A-Programmer-Guide.pdf, section 9.12 Indirect result location 

/*
 **********************************************************************
 *
 * Function name: bar
 *
 * TODO: Update this descripton.
 *
 * Purpose: Create a struct struct_A initialized to the 
 *          parmeters passed to the function, and return 
 *          the struct. See struct_A.h.
 *
 * C interface:
 *          struct struct_A foo(int i0, int i1, double d0, double d1);
 * 
 * Inputs:
 *          | Register | Variable |
 *            w0         i0
 *            w1         i1
 *            d0         d0
 *            d1         d1
 * 
 * Outputs:
 *        * Pointer to struct_A returned from the stack.
 *
 **********************************************************************
 */
.global bar
.type bar, @function
// TODO: Fix this function, wrong usage of stack. We do not return as expected
// when this is called from C code
bar:
    ret
    ///* Create prelude */
    //stp fp, lr, [sp, #0x10]!
    //mov fp, sp

    ///* Create space on the stack for the 
    //   struct's address returned by foo on xr */
    //sub sp, sp, #0x20
    //add x8, sp, #8      // Indirect result location register

    ///* Call function foo() such as: foo(0, 1, 1.0, 2.0) */ 
    //mov w0, wzr 
    //orr w1, wzr, #1
    //fmov d0, #1.0
    //fmov d0, #2.0

    //// Jump to foo to get the struct
    //// bl foo

    ///* Create epilogue */
    //mov sp, x29
    //ldr lr, [SP], #0x10
    //ret
// end bar:

/*
 **********************************************************************
 *
 * Function name: foo
 *
 * Purpose: Create a struct struct_A initialized to the 
 *          parmeters passed to the function, and return 
 *          the struct. See struct_A.h.
 *
 * C interface:
 *          struct struct_A foo(int i0, int i1, double d0, double d1);
 * 
 * Parameters: 
 *        * TODO Stack
 *        * | Register | Variable |
 *            w0         i0
 *            w1         i1
 *            d0         d0
 *            d1         d1
 * 
 * Returns:
 *        * Pointer to struct_A returned from the stack.
 *
 **********************************************************************
 */
foo:
    /* Create space on the stack for all 4 parameters 
       of the function */
    sub sp, sp, #0x30

    /* Push the parameters */
    str w0, [sp, #0x2c]
    str w1, [sp, #0x28]
    str d0, [sp, #0x20]
    str d1, [sp, #0x18]
    
// end foo

.end
