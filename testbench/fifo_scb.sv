class fifo_sbd;
  fifo_tx tx;
  bit [DWIDTH-1:0] model_q[$];
  bit [DWIDTH-1:0] expected_data;
  bit read_pending = 0;

  task run();
    forever begin
      fifo_common::mon2sbd.get(tx);
      if (tx.wr_en && !tx.full)
        model_q.push_back(tx.din);

      if (read_pending) begin
        if (expected_data == tx.dout)
          fifo_common::num_matches++;
        else
          fifo_common::num_mismatches++;
        read_pending = 0;
      end

      if (tx.rd_en && !tx.empty && model_q.size() > 0) begin
        expected_data = model_q.pop_front();
        read_pending = 1;
      end

    end
  endtask

endclass
