
while[null .rdb.GW: @[{hopen (first `::5050,`$x; 5000)}; .Q.opt[.z.x][`gw]; 0Ni]];

.rdb.GW @ (`.gw.register;`;`)

/ TODO error trap
.rdb.query:{[guid;query;callback]
    err:0b;
    res: value query;
    neg[.z.w] @ (callback;guid;err;res)
 };
