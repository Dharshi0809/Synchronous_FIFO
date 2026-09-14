interface fifo_intf(input clk,rst);
  logic wr_en;
  logic rd_en;
  logic [DWIDTH-1:0] din,dout;
  logic full,empty;
  clocking bfm_cb@(posedge clk);
    default input #0 output #1;
    output wr_en,rd_en,din;
    input dout,full,empty;
  endclocking
  clocking mon_cb@(posedge clk);
    default input #2;
    input wr_en,rd_en,din,dout,full,empty;
  endclocking
endinterface
  
