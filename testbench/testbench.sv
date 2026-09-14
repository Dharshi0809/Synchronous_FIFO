`include "fifo_common.sv"
`include "fifo_transaction.sv"
`include "fifo_generator.sv"
`include "fifo_interface.sv"
`include "fifo_bfm.sv"
`include "fifo_mon.sv"
`include "fifo_scb.sv"
`include "fifo_cov.sv"
`include "fifo_agt.sv"
`include "fifo_env.sv"

module top;
  reg clk,rst;
  fifo_intf pif(clk,rst);
  fifo_env env;
  
  sync_fifo#(.DWIDTH(DWIDTH),.DEPTH(DEPTH))
  dut(
    .clk(clk),
    .rst(rst),
    .wr_en(pif.wr_en),
    .rd_en(pif.rd_en),
    .din(pif.din),
    .dout(pif.dout),
    .full(pif.full),
    .empty(pif.empty));
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  initial begin
    rst=1;
    repeat(2)@(posedge clk);
    rst=0;
    env=new();
    env.run();
  end
  initial begin
    #500;
    $display("matches=%0d",fifo_common::num_matches);
    $display("mismatches=%0d",fifo_common::num_mismatches);
    $display("bfm count =%0d",fifo_common::bfm_count);
    $display("mon count =%0d",fifo_common::mon_count);
    $display("coverage== %0.2f %%", $get_coverage());
    $finish;
  end
endmodule
    
    
    
