
/ started with 
/- q rdb.q -p 5001 -procType rdb -procName rdb-1 -procTabs Trade -procSyms

/- util functions

.util.getIp:{"." sv string"h"$0x0 vs .z.a};

/setting proc vars
.proc:.Q.opt .z.x;
.proc.procIP:.util.getIp[];

/- think we should add a warm up time and a first updTime on seperate .rdb.register calls
.rdb.register:{[]
    / open handle
    h:hopen `::5000;
    h(`.gw.register;.z.h;`$.proc.procIP;.proc.procTabs;.proc.procSyms;`$first .proc.procType;`$first .proc.procName)
 };

.rdb.getData:{[tab;st;et;syms;func;cs;guid;callback]
    / run Query
    res:.[func;(tab;st;et;syms;cs);{(1b;x)}]
    / send back to gw
    neg[.z.w](`callback;guid;res)
 };

.rdb.getTicks:{[tab;st;et;symList;cs]
    ?[tab;enlist (within;time;(enlist;st;et);(in;`sym;enlist symList));0b;cs!cs]
    }

n:100
trade:([] time:.z.d+n?0D;sym:n?`3;tp:n?10f;ts:n?100i);


/- .rdb.getData[`trade;2020.10.26D00;2020.10.26D23;symList;`time`sym`tp;`.rdb.getTicks;1?0Ng;`callback]
