📌 Overview

This project implements and verifies a parameterized Synchronous FIFO using Verilog HDL and a SystemVerilog-based verification environment.

The verification focuses on generating different FIFO operating conditions and checking the DUT behavior using a queue-based reference model in the scoreboard.

🔹 DUT – Synchronous FIFO

The FIFO supports:

Write and read operations
Full and empty detection
Synchronous reset
Simultaneous read and write operations
Parameterized data width and FIFO depth
Parameters
DWIDTH – Data width
DEPTH – FIFO depth
AWIDTH – Address width
🔹 SystemVerilog Verification

The generator creates directed test scenarios by controlling wr_en and rd_en according to the FIFO condition.

The generator does not simply apply random transactions. It specifically creates sequences to reach important corner cases.

Test Scenarios Generated

1. Fill FIFO

The generator performs DEPTH consecutive write operations to fill the FIFO completely.

2. Hold FULL

After filling the FIFO, both read and write enables are disabled for one cycle to verify the full condition remains stable.

3. Write When FULL

A write is attempted while the FIFO is already full to verify that unwanted data is not written.

4. Empty FIFO

The generator performs DEPTH consecutive read operations to remove all stored data.

5. Hold EMPTY

Both read and write enables are disabled for one cycle while the FIFO is empty.

6. Read When EMPTY

A read is attempted while the FIFO is empty to verify that invalid data is not read.

7. Simultaneous Write and Read

Multiple cycles of simultaneous write and read operations are generated to verify FIFO behavior when both operations occur together.

8. Idle Condition

An idle transaction with both wr_en and rd_en disabled is generated to test the no-operation condition.

🔹 Scoreboard

The scoreboard uses a SystemVerilog queue as a reference model.

During a valid write, input data is pushed into the reference queue.
During a valid read, the expected data is removed from the front of the queue.
The expected data is compared with the DUT output.
Match and mismatch counts are maintained to determine verification results.
🔹 Verification Flow

Generator → Driver → DUT → Monitor → Scoreboard

The generator creates targeted scenarios, the driver applies them to the DUT, the monitor captures the DUT activity, and the scoreboard compares the actual output against the expected FIFO behavior.

🛠️ Tools & Technologies
Verilog HDL
SystemVerilog
Synopsys VCS
Synopsys Verdi
📁 Project Structure

Synchronous_FIFO/

├── DUT/
│ └── design.sv

└── Testbench/
    ├── testbench.sv
    ├── fifo_tx.sv
    ├── fifo_gen.sv
    ├── fifo_common.sv
    ├── fifo_interface.sv
    ├── fifo_bfm.sv
    ├── fifo_monitor.sv
    └── fifo_sbd.sv
