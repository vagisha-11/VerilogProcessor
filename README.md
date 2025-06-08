# MIPS Single-Cycle Processor (Gate-Level Verilog)

## Overview

This project implements a **32-bit single-cycle MIPS processor** using **Verilog HDL** with a focus on **gate-level integration**. It supports core R-type, I-type, and J-type instructions with manual memory initialization and debugging features designed for educational simulation in Vivado or similar tools.

---

## Key Features

- Single-cycle datapath: all operations complete in one clock cycle.
- **Word-addressed** instruction and data memory.
- **Gate-level ALU** with 32-bit ripple-carry adder.
- Subroutine support via `jal` and `jr`.
- Integration of **gate-level muxes**, decoders, and logic components.
- `$display`-based debug prints for ALU operations and register state.

---

## Supported MIPS Instructions

### R-Type (opcode: `000000`)
| Instruction | Function Code |
|------------|----------------|
| `add rd, rs, rt` | `100000` |
| `sub rd, rs, rt` | `100010` |
| `and rd, rs, rt` | `100100` |
| `or  rd, rs, rt` | `100101` |
| `slt rd, rs, rt` | `101010` |
| `jr rs`         | `001000` |

### I-Type
| Instruction | Opcode |
|------------|--------|
| `lw rt, offset(rs)` | `100011` |
| `sw rt, offset(rs)` | `101011` |
| `beq rs, rt, offset` | `000100` |
| `addi rt, rs, imm` | `001000` |

### J-Type
| Instruction | Opcode |
|------------|--------|
| `j target`     | `000010` |
| `jal target`   | `000011` |

---

## 🔩 Major Modules

### 1. `mem_async.v` - **Instruction Memory**
- 256 x 32-bit word-addressed.
- Initialized manually with hex instructions.

### 2. `mem_sync.v` - **Data Memory**
- 256 x 32-bit.
- Synchronous write on posedge.

### 3. `rf.v` - **Register File**
- 32 x 32-bit registers.
- Register `$0` is hardwired to zero.
- Uses decoders and 32-to-1 MUXes.

### 4. `alu.v` - **ALU**
- Gate-level design using:
  - Bitwise AND, OR, NOR.
  - Ripple-carry adder (32-bit).
  - 2's complement for subtraction.
  - SLT from MSB of result.
- Debug `$display` enabled.

### 5. `ripple_adder_32.v`
- Composed of 1-bit full adders.
- Supports both add/sub logic.

### 6. `control.v`
- Generates control signals based on opcode.
- Handles special instructions: `jal`, `jr`.

### 7. `alucontrol.v`
- Converts `funct` & `ALUOp` → ALU control signals.

### 8. `pclogic.v`
- Determines `PC+4`, branches, jumps, `jr`.

### 9. `datapath.v`
- Main integration unit.
- Handles instruction decode, register access, ALU ops, memory routing, and PC logic.

---

## Simulation Program Example

```assembly
main:
  add $t0, $zero, $zero
  add $t1, $zero, $zero
  jal func
  lw $t1, 64($t0)
  lw $t2, 68($t0)
  lw $t3, 72($t0)
  sw $zero, 76($t0)

loop:
  lw $t4, 0($t0)
  lw $t5, 76($t6)
  add $t5, $t5, $t4
  sw $t5, 76($t6)
  sub $t1, $t1, $t2
  add $t0, $t0, $t3
  beq $t1, $zero, done
  j loop

func:
  addi $t1, $zero, 5
  jr $ra

done:
  j done
