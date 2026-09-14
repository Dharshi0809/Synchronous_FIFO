module sync_fifo#(
  parameter DWIDTH =8,
  parameter DEPTH=8,
  parameter AWIDTH=$clog2(DEPTH))
  (input wire clk,rst,wr_en,rd_en,
   input wire [DWIDTH-1:0] din,
   output reg [DWIDTH-1:0] dout,
   output wire full,empty
  );
  reg [DWIDTH-1:0] mem [0:DEPTH-1];
  reg [AWIDTH:0]wptr;
  reg [AWIDTH:0]rptr;
  
  assign empty =(wptr==rptr);
  assign full =(wptr[AWIDTH]!=rptr[AWIDTH]) && (wptr[AWIDTH-1:0]==rptr[AWIDTH-1:0]);
  
  always@(posedge clk)begin
    if(rst)begin
      wptr<=0;
      rptr<=0;
      dout<=0;
    end
    else begin
      if (wr_en && (!full || (rd_en && !empty))) begin
        mem[wptr[AWIDTH-1:0]]<=din;
        wptr<=wptr+1;
      end
      if(rd_en && !empty)begin
        dout<=mem[rptr[AWIDTH-1:0]];
        rptr<=rptr+1;
      end
    end
  end
endmodule
  
  
  
