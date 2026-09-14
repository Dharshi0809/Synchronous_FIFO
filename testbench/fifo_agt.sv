class fifo_agt;
  fifo_gen g;
  fifo_bfm b;
  fifo_mon m;
  fifo_cov c;
  
  task run();
    g=new();
    b=new();
    m=new();
    c=new();
    
    fork
      g.run();
      b.run();
      m.run();
      c.run();
    join
  endtask
endclass
