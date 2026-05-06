//tb_decoder.v
module tb_decoder;
reg[3:0] opcode;
wire[2:0]alu_op;
wire reg_write;
wire mem_read;
wire mem_write;
wire branch;
wire jump;
wire use_imm;
decoder uut(
.opcode(opcode),
.alu_op(alu_op),
.reg_write(reg_write),
.mem_read(mem_read),
.mem_write(mem_write),
.branch(branch),
.jump(jump),
.use_imm(use_imm)
);
initial begin
$display("Testing CUSTOM16 Decoder!");
    opcode = 4'b0000; #10;  // ADD
    $display("ADD : alu_op=%b reg_write=%b mem_read=%b mem_write=%b branch=%b jump=%b use_imm=%b", alu_op, reg_write, mem_read, mem_write, branch, jump, use_imm);
    opcode = 4'b0001; #10;  // SUB
    $display("SUB : alu_op=%b reg_write=%b mem_read=%b mem_write=%b branch=%b jump=%b use_imm=%b", alu_op, reg_write, mem_read, mem_write, branch, jump, use_imm);
    opcode = 4'b0010; #10;  // MUL
    $display("MUL : alu_op=%b reg_write=%b mem_read=%b mem_write=%b branch=%b jump=%b use_imm=%b", alu_op, reg_write, mem_read, mem_write, branch, jump, use_imm);
    opcode = 4'b0011; #10;  // DIV
    $display("DIV : alu_op=%b reg_write=%b mem_read=%b mem_write=%b branch=%b jump=%b use_imm=%b", alu_op, reg_write, mem_read, mem_write, branch, jump, use_imm);
    opcode = 4'b0100; #10;  // AND
    $display("AND : alu_op=%b reg_write=%b mem_read=%b mem_write=%b branch=%b jump=%b use_imm=%b", alu_op, reg_write, mem_read, mem_write, branch, jump, use_imm);
    opcode = 4'b0101; #10;  // OR
    $display("OR : alu_op=%b reg_write=%b mem_read=%b mem_write=%b branch=%b jump=%b use_imm=%b", alu_op, reg_write, mem_read, mem_write, branch, jump, use_imm);
    opcode = 4'b0110; #10;  // NOT
    $display("NOT : alu_op=%b reg_write=%b mem_read=%b mem_write=%b branch=%b jump=%b use_imm=%b", alu_op, reg_write, mem_read, mem_write, branch, jump, use_imm);
    opcode = 4'b0111; #10;  // LOAD
    $display("LOAD : alu_op=%b reg_write=%b mem_read=%b mem_write=%b branch=%b jump=%b use_imm=%b", alu_op, reg_write, mem_read, mem_write, branch, jump, use_imm);
    opcode = 4'b1000; #10;  // STORE
    $display("STORE : alu_op=%b reg_write=%b mem_read=%b mem_write=%b branch=%b jump=%b use_imm=%b", alu_op, reg_write, mem_read, mem_write, branch, jump, use_imm);
    opcode = 4'b1001; #10;  // MOVI
    $display("MOVI : alu_op=%b reg_write=%b mem_read=%b mem_write=%b branch=%b jump=%b use_imm=%b", alu_op, reg_write, mem_read, mem_write, branch, jump, use_imm);
    opcode = 4'b1010; #10;  // JUMP
    $display("JUMP : alu_op=%b reg_write=%b mem_read=%b mem_write=%b branch=%b jump=%b use_imm=%b", alu_op, reg_write, mem_read, mem_write, branch, jump, use_imm);
    opcode = 4'b1011; #10;  // BEQ
    $display("BEQ : alu_op=%b reg_write=%b mem_read=%b mem_write=%b branch=%b jump=%b use_imm=%b", alu_op, reg_write, mem_read, mem_write, branch, jump, use_imm);
    opcode = 4'b1100; #10;  // BNE
    $display("BNE : alu_op=%b reg_write=%b mem_read=%b mem_write=%b branch=%b jump=%b use_imm=%b", alu_op, reg_write, mem_read, mem_write, branch, jump, use_imm);
    opcode = 4'b1101; #10;  // HALT
    $display("HALT : alu_op=%b reg_write=%b mem_read=%b mem_write=%b branch=%b jump=%b use_imm=%b", alu_op, reg_write, mem_read, mem_write, branch, jump, use_imm);
$display("Simulation complete.");
$finish;
end
endmodule