import argparse
from parser import ISASpec
from validator import ISAValidator
from emitter import VerilogEmitter
import sys
import subprocess

parser = argparse.ArgumentParser(description="CUSTOM16 RTL Toolchain")
parser.add_argument("isa", help="Path to ISA spec JSON")
parser.add_argument("--simulate", action="store_true", help="Run simulation")
args = parser.parse_args()

spec = ISASpec(args.isa)
validator = ISAValidator(spec)
errors = validator.validate()
if errors:
    for e in errors:
        print("ERROR: " + e)
    sys.exit(1)  # stop here, don't generate any Verilog
else:
    emitter = VerilogEmitter(spec, "../generated")
    emitter.emit_decoder()
    emitter.emit_testbench()
    emitter.emit_control_rom()
    if args.simulate:
         subprocess.run(["iverilog", "-o", "../generated/sim.vvp","../generated/decoder.v", "../generated/tb_decoder.v"])
         subprocess.run(["vvp", "../generated/sim.vvp"])

