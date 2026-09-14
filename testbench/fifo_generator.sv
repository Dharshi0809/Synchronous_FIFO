class fifo_gen;

  fifo_tx tx;

  task run();

    // Fill FIFO
    repeat (DEPTH) begin
      tx = new();
      tx.randomize() with {
   			wr_en == 1;
   			rd_en == 0;
      };
      fifo_common::gen2bfm.put(tx);
    end

    // HOLD FULL for one cycle
    tx = new();
    tx.randomize() with {
      wr_en == 0;
      rd_en == 0;
    };
    fifo_common::gen2bfm.put(tx);

    // Write when FULL
    tx = new();
    tx.randomize() with {
      wr_en == 1;
      rd_en == 0;
    };
    fifo_common::gen2bfm.put(tx);

    // Empty FIFO
    repeat (DEPTH) begin
      tx = new();
      tx.randomize() with {
        wr_en == 0;
        rd_en == 1;
      };
      fifo_common::gen2bfm.put(tx);
    end

    // HOLD EMPTY for one cycle
    tx = new();
    tx.randomize() with {
      wr_en == 0;
      rd_en == 0;
    };
    fifo_common::gen2bfm.put(tx);

    // Read when EMPTY
    tx = new();
    tx.randomize() with {
      wr_en == 0;
      rd_en == 1;
    };
    fifo_common::gen2bfm.put(tx);

    // Simultaneous WR+RD
    repeat (5) begin
      tx = new();
      tx.randomize() with {
        wr_en == 1;
        rd_en == 1;
      };
      fifo_common::gen2bfm.put(tx);
    end

    // Explicit idle (for cross 0,0)
    tx = new();
    tx.randomize() with {
      wr_en == 0;
      rd_en == 0;
    };
    fifo_common::gen2bfm.put(tx);

  endtask

endclass
