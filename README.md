# CUSTOM16 RTL Toolchain

A Python-based toolchain that automatically generates synthesizable Verilog RTL from a JSON ISA specification — eliminating manual RTL authoring for a custom 16-bit processor ISA.

## What This Is

Most RTL workflows require engineers to hand-write Verilog for every instruction in a processor's ISA. This toolchain takes a different approach — the ISA is defined once in a JSON spec file, and the toolchain automatically generates the Verilog control logic from it. Change the spec, re-run one command, and new correct Verilog comes out.

The JSON spec is the **single source of truth**. Nothing is hardcoded anywhere else.

## Project Structure

```
RTL_Toolchain/
├── isa_spec.json          # ISA specification — 14 instructions, 7 control signals
├── toolchain/
│   ├── parser.py          # Reads JSON spec, builds Python objects
│   ├── validator.py       # Catches spec errors before Verilog is emitted
│   ├── emitter.py         # Generates Verilog RTL from parsed spec
│   ├── main.py            # CLI entry point — runs full pipeline
│   └── error_tests.py     # Error injection tests for the validator
└── generated/
    ├── decoder.v          # Auto-generated case-based control unit decoder
    ├── control_rom.v      # Auto-generated ROM-based control unit
    └── tb_decoder.v       # Auto-generated simulation testbench
```

## How To Run

### Requirements
- Python 3.x
- [Icarus Verilog](https://bleyer.org/icarus/) (iverilog + vvp)

### Run the full pipeline
```bash
cd toolchain
python main.py ../isa_spec.json --simulate
```

This single command:
1. Parses the ISA spec
2. Validates it — stops if errors are found
3. Generates `decoder.v`, `control_rom.v`, and `tb_decoder.v`
4. Compiles with iverilog and runs simulation

### Run without simulation
```bash
python main.py ../isa_spec.json
```

### Run error injection tests
```bash
python error_tests.py
```

## ISA Design — CUSTOM16

A custom 16-bit ISA with 14 instructions across two formats.

**Instruction word:** 16 bits  
**Opcode:** 4 bits (16 possible instructions)  
**Registers:** 8 general purpose (R0–R7, 3 bits each)

### Instruction Formats

**R-type** (register operations):
```
[15:12] opcode | [11:9] rs | [8:6] rt | [5:3] rd | [2:0] unused
```

**I-type** (immediate/memory/branch):
```
[15:12] opcode | [11:9] rs | [8:6] rt/rd | [5:0] immediate
```

### Instruction Set

| Opcode | Mnemonic | Format | Description |
|--------|----------|--------|-------------|
| 0000   | ADD      | R      | rd = rs + rt |
| 0001   | SUB      | R      | rd = rs - rt |
| 0010   | MUL      | R      | rd = rs * rt |
| 0011   | DIV      | R      | rd = rs / rt |
| 0100   | AND      | R      | rd = rs AND rt |
| 0101   | OR       | R      | rd = rs OR rt |
| 0110   | NOT      | R      | rd = NOT rs |
| 0111   | LOAD     | I      | rd = mem[imm] |
| 1000   | STORE    | I      | mem[imm] = rs |
| 1001   | MOVI     | I      | rd = imm |
| 1010   | JUMP     | I      | PC = imm |
| 1011   | BEQ      | I      | if rs==rt: PC=imm |
| 1100   | BNE      | I      | if rs!=rt: PC=imm |
| 1101   | HALT     | R      | Stop execution |

### Control Signals

| Signal    | Width | Description |
|-----------|-------|-------------|
| alu_op    | 3 bits | ALU operation (000=add, 001=sub, 010=mul, 011=div, 100=and, 101=or, 110=not, 111=none) |
| reg_write | 1 bit  | Write result to register |
| mem_read  | 1 bit  | Read from memory |
| mem_write | 1 bit  | Write to memory |
| branch    | 1 bit  | Conditional branch instruction |
| jump      | 1 bit  | Unconditional jump |
| use_imm   | 1 bit  | Use immediate value |

## Toolchain Pipeline

```
isa_spec.json
      │
      ▼
  parser.py ──────────── Reads JSON, builds Python objects
      │                  (ISASpec, Instruction, ControlSignal)
      ▼
 validator.py ─────────── Catches errors before emission:
      │                  • Duplicate opcodes
      │                  • Wrong opcode bit length
      │                  • Missing control signals
      │                  • Signal width mismatches
      ▼
  emitter.py ─────────── Generates Verilog RTL:
      │                  • decoder.v (case-based control unit)
      │                  • control_rom.v (ROM-based control unit)
      │                  • tb_decoder.v (simulation testbench)
      ▼
   iverilog ──────────── Compiles and simulates generated RTL
      │
      ▼
Simulation output ────── All 14 instructions verified correct
```

## Generated Output

### decoder.v
Case-based combinational decoder. For each opcode, outputs the 7 control signals as a Verilog `case` statement.

```verilog
always @(*) begin
    case (opcode)
        4'b0000: begin  // ADD
            alu_op    = 3'b000;
            reg_write = 1'b1;
            mem_read  = 1'b0;
            ...
        end
        ...
    endcase
end
```

### control_rom.v
ROM-based control unit. Stores all control words in a pre-initialized memory array. More scalable for large instruction sets.

```verilog
reg [8:0] rom [15:0];
initial begin
    rom[4'b0000] = 9'b000100000;  // ADD
    rom[4'b0001] = 9'b001100000;  // SUB
    ...
end
assign control_word = rom[opcode];
```

## Simulation Output

```
Testing CUSTOM16 Decoder!
ADD  : alu_op=000 reg_write=1 mem_read=0 mem_write=0 branch=0 jump=0 use_imm=0
SUB  : alu_op=001 reg_write=1 mem_read=0 mem_write=0 branch=0 jump=0 use_imm=0
LOAD : alu_op=111 reg_write=1 mem_read=1 mem_write=0 branch=0 jump=0 use_imm=1
STORE: alu_op=111 reg_write=0 mem_read=0 mem_write=1 branch=0 jump=0 use_imm=1
BEQ  : alu_op=001 reg_write=0 mem_read=0 mem_write=0 branch=1 jump=0 use_imm=1
JUMP : alu_op=111 reg_write=0 mem_read=0 mem_write=0 branch=0 jump=1 use_imm=1
HALT : alu_op=111 reg_write=0 mem_read=0 mem_write=0 branch=0 jump=0 use_imm=0
Simulation complete.
```

## Validator Error Detection

```bash
python error_tests.py
```
```
PASS: duplicate opcode detected
PASS: wrong bit width detected
PASS: missing signal detected
```

## Why Two RTL Implementations?

The same JSON spec generates both a case-based decoder and a ROM-based control unit — demonstrating that the toolchain can produce multiple RTL architectures from a single source of truth.

- **Case-based decoder** — synthesizes to a priority mux, efficient for small ISAs
- **ROM-based control unit** — scales better for large instruction sets, closer to microcoded control units used in real processors like x86

## Built With

- Python 3.x
- Verilog / Icarus Verilog
- JSON

## Author

Vivek — MS Computer Engineering, University of Kentucky
