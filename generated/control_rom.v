//control _rom.v
module control_rom(
  input[3:0] opcode,
  output[8:0] control_word
);
reg[8:0] rom[15:0];
initial begin
        rom[4'b0000] = 9'b000100000;  // ADD
        rom[4'b0001] = 9'b001100000;  // SUB
        rom[4'b0010] = 9'b010100000;  // MUL
        rom[4'b0011] = 9'b011100000;  // DIV
        rom[4'b0100] = 9'b100100000;  // AND
        rom[4'b0101] = 9'b101100000;  // OR
        rom[4'b0110] = 9'b110100000;  // NOT
        rom[4'b0111] = 9'b111110001;  // LOAD
        rom[4'b1000] = 9'b111001001;  // STORE
        rom[4'b1001] = 9'b111100001;  // MOVI
        rom[4'b1010] = 9'b111000011;  // JUMP
        rom[4'b1011] = 9'b001000101;  // BEQ
        rom[4'b1100] = 9'b001000101;  // BNE
        rom[4'b1101] = 9'b111000000;  // HALT
end
assign control_word = rom[opcode];
endmodule