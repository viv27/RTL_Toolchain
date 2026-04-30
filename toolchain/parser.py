import json

class Instruction:
    def __init__(self,mnemonic,opcode,format, description,control):
        self.mnemonic = mnemonic
        self.opcode = opcode
        self.format = format
        self.description = description
        self.control = control

class ControlSignal:
    def __init__(self,name,width):
        self.name = name
        self.width = width

class ISASpec:
    def __init__(self,filePath):
        with open(filePath) as f:
            data = json.load(f)
        self.isa_name = data['isa_name']
        self.description = data['description']
        self.word_width = data['word_width']
        self.opcode_bits = data['opcode_bits']
        self.num_registers = data['num_registers']
        self.Instructions = []
        for n in data["instructions"]:
            self.Instructions.append(Instruction(n['mnemonic'],n['opcode'],n['format'],n['description'],n['control']))
       
        self.ControlSignals = []
        for n in data["control_signals"]:
         self.ControlSignals.append(ControlSignal(n['name'],n['width']))


# will only print here, won't print if imported
if __name__ == "__main__": 
    spec = ISASpec("../isa_spec.json")
    print(spec.isa_name)
    print(len(spec.Instructions))
    print(len(spec.ControlSignals))
    print(spec.ControlSignals[0].name)