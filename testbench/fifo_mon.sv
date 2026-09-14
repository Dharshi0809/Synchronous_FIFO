class fifo_mon;
  fifo_tx tx;
  virtual fifo_intf vif;
  function new();
    vif=top.pif;
  endfunction
  task run();
    forever begin
      @(vif.mon_cb);
      
        tx=new();
      	tx.wr_en=vif.mon_cb.wr_en;
      	tx.rd_en=vif.mon_cb.rd_en;
      	tx.din=vif.mon_cb.din;
      	tx.dout=vif.mon_cb.dout;
      	tx.full=vif.mon_cb.full;
      	tx.empty=vif.mon_cb.empty;
      
      	fifo_common::mon2sbd.put(tx);
      	fifo_common::mon2cov.put(tx);
      	fifo_common::mon_count++;
     
      
    end
  endtask
endclass

     
