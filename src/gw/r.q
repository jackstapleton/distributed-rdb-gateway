/ started with 
/- q rdb.q -p 5001 -procType rdb -procName rdb-1 -procTabs Trade -procSyms

/- util functions

.util.getIp:{"." sv string"h"$0x0 vs .z.a};

/setting proc vars
.proc:.Q.opt .z.x;
.proc.procIP:.util.getIp[];

/- Norm rdb code - Jack has this 

.rdb.register:{[]
    / open handle
    h:hopen `::5000;
    h(`.gw.register;.z.h;`$.proc.procIP;.proc.procTabs;.proc.procSyms;`$first .proc.procType;`$first .proc.procName)
 };


/- request:(func;tab;st;et;syms;guid);

.rdb.getData:{[tab;st;et;syms;guid]
    / run Query
    res:.[.rdb.getTicks;(tab;st;et;syms);{(1b;x)}];
    / send back to gw
    neg[.z.w](`.gw.callback;guid;res)
 };

.rdb.getTicks:{[tab;st;et;symList]
    r:?[tab;((within;`time;(st;et));(in;`sym;enlist symList));0b;()];
    (0b;r)
  };

n:100
trade:([] time:.z.d+n?0D;sym:n?`$.proc.procSyms;tp:n?10f;ts:n?100i);

.rdb.register[];
/- .rdb.getData[`trade;2020.10.26D00;2020.10.26D23;symList;`time`sym`tp;`.rdb.getTicks;1?0Ng;`callback]
