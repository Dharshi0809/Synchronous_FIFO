class fifo_env;
  fifo_agt a;
  fifo_sbd s;
  task run();
    a=new();
    s=new();
    
    fork
      a.run();
      s.run();
    join
  endtask
endclass
