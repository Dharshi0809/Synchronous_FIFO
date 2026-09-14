class fifo_tx;
  rand bit wr_en;
  rand bit rd_en;
  rand bit [DWIDTH-1:0] din;
  bit[DWIDTH-1:0]dout;
  bit full;
  bit empty;
  function void print(string name="");
    $display("[%s] wr=%0b rd=%0b din=%0d dout=%0d full=%0b empty=%0b",name,wr_en,rd_en,din,dout,full,empty);
  endfunction
endclass
