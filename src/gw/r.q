
.rdb.register:{[hpup]
    / open handle
    / send (`.gw.register;tabs;syms)
 };

.rdb.query:{[guid;query;callback]
    / run query
    / send back to gw
    / (callback;guid;res)
 };
