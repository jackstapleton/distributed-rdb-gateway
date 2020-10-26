/- we should add a connectTime and initialize time . 
/- As the rdb will be up for awhile prior to receiving data 

/- are all tables and all symbols not going to all rdbs ? 
.gw.servers: flip `time`handle`host`ip`tabs`syms`procType`procName!();
`.gw.servers upsert (0Np;0Ni;`;`;();();`;`);


.gw.requests: flip `time`guid`userHandle`rdbHandle`request`res!();
`.gw.requests upsert (0Np;0Ng;0Ni;0Ni;();());

/- function called after rdb initializes connection
.gw.register:{[host;ip;tabs;syms;procType;procName]
    / add rdb to .gw.servers
    `.gw.servers upsert (.z.p;.z.w;host;ip;tabs;syms;procType;procName)
 };

.gw.request:{[tab;syms;func;st;et]
    / use deferred sync
    -30!(::);
    / add request to .gw.requests
    request:(`rdb.getData;tab;syms;func;st;et);
    `.gw.requests upsert (.z.p;guid;.z.w;rdbHandles;request;())
    
    / send a query to each rdb
    / (`.rdb.query;guid;query;callback)
 };

.gw.callback:{[guid;res]
    / add res to .gw.requests
    / if all requests complete return to handle
    / combine all requests if a requests are returned
 };
 
