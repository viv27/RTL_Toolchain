module decoder(input [3:0] opcode,
output reg [2:0]alu_op,
output reg reg_write,
output reg mem_read,
output reg mem_write,
output reg branch,
output reg jump,
output reg use_imm);



always @(*)begin

case(opcode)
    4'b0000:
        begin
            alu_op = 3'b000;
            reg_write = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            jump = 1'b0;
            use_imm = 1'b0;

        end
    
    4'b0001:
        begin
            alu_op = 3'b001;
            reg_write = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            jump = 1'b0;
            use_imm = 1'b0;
        end
    
    4'b0010:
        begin
            alu_op = 3'b010;
            reg_write = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            jump = 1'b0;
            use_imm = 1'b0;
        end
    
    4'b0011:
        begin
            alu_op = 3'b010;
            reg_write = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            jump = 1'b0;
            use_imm = 1'b0; 
        end
    
    4'b0100:
        begin
            alu_op = 3'b100;
            reg_write = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            jump = 1'b0;
            use_imm = 1'b0;
        end
    
    4'b0101:
        begin
            alu_op = 3'b101;
            reg_write = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            jump = 1'b0;
            use_imm = 1'b0; 
        end
    
    4'0110:
        begin
            alu_op = 3'b110;
            reg_write = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            jump = 1'b0;
            use_imm = 1'b0;
        end
    
    4'b0111:
        begin
            alu_op = 3'b111;
            reg_write = 1'b1;
            mem_read = 1'b1;
            mem_write = 1'b0;
            branch = 1'b0;
            jump = 1'b0;
            use_imm = 1'b1; 
        end
    

    4'b1000:
        begin
            alu_op = 3'b111;
            reg_write = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b1;
            branch = 1'b0;
            jump = 1'b0;
            use_imm = 1'b1;  
        end
    
    4'b1001:
        begin
            alu_op = 3'b111;
            reg_write = 1'b1;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            jump = 1'b0;
            use_imm = 1'b1;  
        end
    
    4'b1010:
        begin
            alu_op = 3'b111;
            reg_write = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            jump = 1'b1;
            use_imm = 1'b1; 
        end
    
    4'b1011:
        begin
            alu_op = 3'b001;
            reg_write = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b1;
            jump = 1'b0;
            use_imm = 1'b1; 
        end
    
    4'b1100:
        begin
            alu_op = 3'b001;
            reg_write = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b1;
            jump = 1'b0;
            use_imm = 1'b1;
        end
    
    4'b1101:
        begin
            alu_op = 3'b111;
            reg_write = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            jump = 1'b0;
            use_imm = 1'b0;
        end
        
    4'b1101:
        #halt