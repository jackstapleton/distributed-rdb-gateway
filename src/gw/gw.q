
.gw.servers: flip `time`handle`host`ip`tabs`syms!();
`.gw.servers upsert (0Np;0Ni;`;`;();());


.gw.requests: flip `time`guid`userHandle`rdbHandle`res!();
`.gw.servers upsert (0Np;0Ng;0Ni;());

.gw.register:{[tabs;syms]
    / add rdb to .gw.servers
 };

.gw.request:{[tab;syms;operator;times]
    / use deferred sync
    / add request to .gw.requests
    / send a query to each rdb
    / (`.rdb.query;guid;query;callback)
 };

.gw.callback:{[guid;res]
    / add res to .gw.requests
    / if all requests complete return to handle
 };
