class fifo_bfm;
  fifo_tx tx;
  virtual fifo_intf vif;
  function new();
    vif=top.pif;
  endfunction
  task run();
    forever begin
      fifo_common::gen2bfm.get(tx);
      drive(tx);
      fifo_common::bfm_count++;
    end
  endtask
  task drive(fifo_tx tx);
    @(vif.bfm_cb);
    vif.bfm_cb.wr_en<=tx.wr_en;
    vif.bfm_cb.rd_en<=tx.rd_en;
    vif.bfm_cb.din<=tx.din;
    @(vif.bfm_cb);
    tx.dout=vif.bfm_cb.dout;
    tx.full=vif.bfm_cb.full;
    tx.empty=vif.bfm_cb.empty;
    
    vif.bfm_cb.wr_en <= 0;
    vif.bfm_cb.rd_en <= 0;
    vif.bfm_cb.din   <= 0;
  endtask
endclass
    
    
