# Calculator in Jack  

This project implements a calculator using **Jack**, a simple object-oriented programming language similar to Java, developed as part of the Nand2Tetris curriculum.  

## Requirements  
To run this calculator, you need tools from the open-source **Nand2Tetris textbook**. Download them here:  
[Download Nand2Tetris Tools](https://drive.google.com/file/d/1xZzcMIUETv3u3sdpM_oTJSTetpVee3KZ/view)  

### Tools Needed:  
1. **VMEmulator** - Executes the compiled virtual machine code.  
2. **JackCompiler** - Converts Jack code into VM code.  

## Features  
The calculator uses **Reverse Polish Notation (RPN)** for input, functioning like a stack-based system. Below is a list of available operations and their triggers:  

### Basic Operations  
- **Addition (`+`)**: Pops the top two numbers, adds them, and pushes the result.  
- **Subtraction (`-`)**: Pops the top two numbers, subtracts, and pushes the result.  
- **Multiplication (`*`)**: Pops two numbers, multiplies them, and pushes the result.  
- **Division (`/`)**: Pops two numbers, divides, and pushes the result.  

### Advanced Functions  
- **Exponential (`W`)**: Pops one number, `x`, and pushes `e^x`.  
- **Natural Log (`L`)**: Computes the natural log of the top number and pushes the result.  
- **Root (`R`)**: Pops two numbers, `x` and `y`, and pushes `x^(1/y)`.  
- **Power (`^`)**: Pops two numbers, `x` and `y`, and pushes `x^y`.  
- **Trigonometric Functions**:  
  - **Sine (`S`)**: Computes `sin(x)` for the top number.  
  - **Cosine (`C`)**: Computes `cos(x)` for the top number.  
  - **Tangent (`T`)**: Computes `tan(x)` for the top number.  

### Constants and Precision  
- **Pi (`P`)** and **e (`E`)** are preloaded constants.  
- Results are returned with precision controlled by the variable `precision` (default: 16).  

## Additional Notes  
- **Custom Arithmetic**: Multiplication and division are implemented using repeated addition and subtraction (no external libraries).  
- **Mathematical Approximations**: Advanced functions use summation approximations and may exhibit minor variations for larger numbers.  
- **Hardware Limitations**:  
  - Designed to run on an Intel 8085 microprocessor with 64KB of RAM.  
  - Performance may be slower compared to modern calculators.  

This project highlights the challenges and ingenuity of building a functional calculator within constrained hardware environments and using low-level computational tools.  
