parameter DEPTH=8;
parameter DWIDTH=8;
parameter AWIDTH=$clog2(DEPTH);
class fifo_common;
  static int count=25;
  static int bfm_count;
  static int mon_count;
  static int num_matches;
  static int num_mismatches;
  static mailbox gen2bfm=new();
  static mailbox mon2sbd=new();
  static mailbox mon2cov=new();
endclass
