# JackVM Calculator 🧮


A comprehensive calculator system built from the ground up, featuring arbitrary-precision arithmetic and direct hardware interfacing. The implementation spans from high-level object-oriented design in Jack to low-level 8085 assembly optimizations.
## Technical Architecture

### Core Components
- **Virtual Machine Implementation**: Custom VM translator targeting 8085 assembly
- **Memory Management**: Optimized heap allocation system starting at 4100h
- **I/O System**: Memory-mapped keyboard scanning (8010-8013h) and display output (8000-8007h)
- **Timing Control**: Precision one-second delay implementation for real-time operations

### Hardware Interface
| Component | Memory Address | Function |
|-----------|---------------|-----------|
| Display Output | 8000-8007h | Seven-segment display control |
| Keyboard Input | 8010-8013h | Real-time key scanning |
| Stack Init | 40FFh | Initial stack pointer location |
| Heap Management | 4100h | Dynamic memory allocation |

## Key Features

### Mathematical Operations
- **RPN Calculator**: Stack-based Reverse Polish Notation
- **Basic Operations**: Addition, Subtraction, Multiplication, Division
- **Advanced Functions**: Exponential, Natural Log, Root, Power
- **Trigonometric Functions**: Sine, Cosine, Tangent
- **Constants**: Pi (P) and e (E)

### System Design
- **Memory Efficiency**: Custom heap allocation with garbage collection
- **Real-time Processing**: Optimized keyboard scanning algorithm
- **Display Management**: Efficient seven-segment refresh system
- **Timing Control**: Calibrated one-second delay routines

## Implementation Details

### Assembly Optimizations
- Precise timing calibration for consistent one-second delays
- Efficient keyboard debouncing implementation
- Optimized display refresh cycles
- Direct memory-mapped I/O handling

### Core Algorithms
- Stack-based expression evaluation
- Arbitrary precision arithmetic
- Real-time I/O processing
- Memory-efficient string handling
