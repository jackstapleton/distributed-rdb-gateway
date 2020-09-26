
.rdb.open:{ while[null .rdb.GW: @[{hopen (first `::5050,`$x; 5000)}; .Q.opt[.z.x][`gw]; 0Ni]] };
.rdb.open[];
.rdb.GW @ (`.gw.register;`;`)

/ TODO error trap
.rdb.query:{[guid;query;callback]
    err:0b;
    res: value query;
    neg[.z.w] @ (callback;guid;err;res)
 };

n:10000;
trade:([] time:asc 10000?.z.t; sym: n?`JPM`APPL`GOOG`GE`AMZN; exch:n?`NY`LN`JP; price:102-n?4f; size:10*n?til 10);

.z.pc:{ if[x=.rdb.GW; .rdb.open[]; .rdb.GW @ (`.gw.register;`;`)]; }
