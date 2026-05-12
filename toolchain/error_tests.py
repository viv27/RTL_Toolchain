import json
from parser import ISASpec
from validator import ISAValidator

def test_duplicate_opcode():
    with open("../isa_spec.json") as f:
        data = json.load(f)
    
    data["instructions"][1]["opcode"] = "0010"
    

    
    with open("../temp_test.json", "w") as f:
        json.dump(data, f)
    
    spec = ISASpec("../temp_test.json")
    validator = ISAValidator(spec)
    errors = validator.validate()
    assert len(errors) > 0, "Should have caught an error"
    print("PASS: duplicate opcode detected")

def test_wrong_bit_width():
    with open("../isa_spec.json") as f:
        data = json.load(f)
    
    
    data["instructions"][2]["control"]["reg_write"] = "33"

    
    with open("../temp_test.json", "w") as f:
        json.dump(data, f)
    
    spec = ISASpec("../temp_test.json")
    validator = ISAValidator(spec)
    errors = validator.validate()
    assert len(errors) > 0, "Should have caught an error"
    print("PASS: duplicate bit width detected")



def test_missing_signal():
    with open("../isa_spec.json") as f:
        data = json.load(f)
    
    
    del data["instructions"][0]["control"]["branch"]

    
    with open("../temp_test.json", "w") as f:
        json.dump(data, f)
    
    spec = ISASpec("../temp_test.json")
    validator = ISAValidator(spec)
    errors = validator.validate()
    assert len(errors) > 0, "Should have caught an error"
    print("PASS: missing signal")

test_duplicate_opcode()
test_wrong_bit_width()
test_missing_signal()