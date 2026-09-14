class fifo_cov;

  fifo_tx tx;

  covergroup cg;

    option.per_instance = 1;

    WR_EN : coverpoint tx.wr_en {
      bins wr0 = {0};
      bins wr1 = {1};
    }

    RD_EN : coverpoint tx.rd_en {
      bins rd0 = {0};
      bins rd1 = {1};
    }
    
    FULL_CP : coverpoint tx.full {
      bins full0 = {0};
      bins full1 = {1};
    }

    EMPTY_CP : coverpoint tx.empty {
      bins empty0 = {0};
      bins empty1 = {1};
    }


    // Write behavior relative to FULL
    WR_FULL_CROSS : cross WR_EN, FULL_CP;

    // Read behavior relative to EMPTY
    RD_EMPTY_CROSS : cross RD_EN, EMPTY_CP;

    // All enable combinations
    CTRL_CROSS : cross WR_EN, RD_EN;

	 FULL_TRANS : coverpoint tx.full {
      bins rise = (0 => 1);   // FIFO becomes full
      bins fall = (1 => 0);   // FIFO leaves full
    }

    EMPTY_TRANS : coverpoint tx.empty {
      bins rise = (0 => 1);   // FIFO becomes empty
      bins fall = (1 => 0);   // FIFO leaves empty
    }

   

  endgroup

  function new();
    cg = new();
  endfunction

  task run();
    forever begin
      fifo_common::mon2cov.get(tx);
      cg.sample();
    end
  endtask

endclass

  
  
