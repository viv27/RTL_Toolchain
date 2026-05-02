# validator.py
# Validates the ISA spec for errors before any Verilog is emitted
# Checks: duplicate opcodes, opcode bit length, missing signals, signal width mismatches





from parser import ISASpec

class ISAValidator:
   def __init__(self,spec):
      self.spec = spec
      self.errors = []
    
   def validate(self):
      duplicate ={}
      for n in self.spec.Instructions:  #to check for duplicate opcodes
       if (n.opcode in duplicate):
        
        self.errors.append("Duplicate opcode " + n.opcode + " found in " + duplicate[n.opcode] + " and " + n.mnemonic)
       else:
        duplicate[n.opcode] = n.mnemonic

      for n in self.spec.Instructions:  #to check for opcode bit length
       if(len(n.opcode) != self.spec.opcode_bits):
         self.errors.append("Opcode bit of "+n.mnemonic+" is not "+str(self.spec.opcode_bits)+ " bits long")

      for n in self.spec.Instructions:
         for m in self.spec.ControlSignals:
            if (m.name not in n.control):
               self.errors.append(m.name+" is not there in "+ n.mnemonic)
            elif (len(n.control[m.name]) != m.width):
               self.errors.append(m.name+" of "+ n.mnemonic+ " does not have the correct bits" )
            
         
      return self.errors
      

if __name__ == "__main__":
    spec = ISASpec("../isa_spec.json")
    validator = ISAValidator(spec)
    errors = validator.validate()
   
    if errors:
        for e in errors:
            print("ERROR: " + e)
    else:
        print("Validation passed.")



