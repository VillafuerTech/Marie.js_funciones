// Jump to the start of the program
Jump StartProgram

// Variable declarations
num1, Hex 1                   // The input number for which factorial is calculated
factorial, Hex 1              // The factorial result, initialized to 1
intermediateResult, Hex 0     // Stores intermediate results during multiplication
counter, Hex 1                // Counter for the loop, initially 1
multiplier, Hex 1             // Counter for multiplication, initially 1
One, Hex 1                    // Constant 1, used for incrementing and decrementing

// Program start: main program to calculate factorial
StartProgram, Input
Store num1                    // Store the input in the 'num1' variable

// Loop to calculate factorial by iterative multiplication
LoopFactorial, Load counter       // Load the current value of counter
JnS MultiplyByFactorial           // Jump to multiplication function and save return address
Load counter                      // Reload counter after multiplication
Add One                           // Increment counter by 1
Store counter                     // Update counter
Subt num1                         // Check if counter reached num1
Skipcond 400                      // Skip next instruction if result is zero (end of loop)
Jump LoopFactorial                // Loop again if condition is not met

// Output the final factorial result
Load factorial                    // Load the calculated factorial
Output
Halt

// MultiplyByFactorial function: multiplies current factorial by 'counter'
MultiplyByFactorial, Hex 0        // Store return address here (subroutine start)
Store multiplier                  // Store 'counter' as the multiplier for this multiplication
Load factorial                    // Load current factorial value
Store intermediateResult          // Store it as intermediate result

// Loop to multiply factorial by the current 'counter'
MultiplyLoop, Load intermediateResult  // Load the current intermediate result
Add factorial                           // Add factorial to itself (intermediate += factorial)
Store intermediateResult                // Store new intermediate result
Load multiplier                         // Load multiplier (counter value)
Subt One                                // Decrement multiplier by 1
Store multiplier                        // Update multiplier
Skipcond 400                            // If multiplier reaches 0, exit loop
Jump MultiplyLoop                       // Continue loop until multiplier is 0

// After loop, store intermediate result as the new factorial value
Load intermediateResult                 // Load final intermediate result
Store factorial                         // Update factorial with multiplied result
JumpI MultiplyByFactorial               // Return to the calling address