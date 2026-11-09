module ZirveRV8 (
    input clkn, rstn,
    output [7:0] data_out, data_in,
    output [7:0] tbDR, tbAC, tbAR, tbPC, tbIR, tbBus
);
    
    wire we;
    wire [7:0] from_mem, adr,to_mem; 
    wire [7:0] testDR, testAC, testAR, testPC, testIR, testBus;
    
    assign data_out=from_mem;
    assign data_in=to_mem;
    //test amaçlý
    assign tbDR=testDR;
    assign tbAC=testAC;
    assign tbPC=testPC;
    assign tbAR=testAR;
    assign tbIR=testIR;
    assign tbBus=testBus;
    
    zinde_cpu_8bit cpu(
        .clk(clkn), 
        .rst(rstn),
        .from_memory(from_mem),
        //output
        .to_memory(to_mem), 
        .address(adr),
        .write(we),
        //test output
        .testDR(testDR), 
        .testAC(testAC), 
        .testAR(testAR), 
        .testPC(testPC),
        .testIR(testIR),
        .testBus(testBus)
    );
    
    ram
    #(
        .DATA_WIDTH(4'h8),
        .ADDR_WIDTH(4'h8)
    )
    ram256byte (
        .clk(clkn),
        .we(we),
        .addr(adr),
        .din(to_mem),
        .dout(from_mem)
    );
    
endmodule
