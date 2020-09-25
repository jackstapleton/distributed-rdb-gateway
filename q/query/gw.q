
.gw.servers: flip `time`w`host`tabList`symsList!();
`.gw.servers upsert (0Np; 0Ni; `; (); ());

/
`.gw.servers upsert (.z.p; 5i; .z.h; `; `);
`.gw.servers upsert (.z.p; 6i; .z.h; `; `);
`.gw.servers upsert (.z.p; 7i; .z.h; `; `);
`.gw.servers upsert (.z.p; 8i; .z.h; `; `);
\

/
TODO
decide on format anymap or flat table
.gw.requests: `guid`rdbHandle xkey flip `guid`rdbHandle`started`finished`error`result!();
`.gw.requests upsert (0Ng; 0Ni; 0Np; 0Np; 0b; ());
\

.gw.requests:()!();


.gw.register:{[tabs;syms]
    / TODO
    / add start & end times
    `.gw.servers upsert (.z.p; .z.w; .z.h; tabs; syms);
 };

.gw.zpg:{[x]
    / TODO
    / parse query
    / run .gw.request
 };

/
tab:`trade;
syms:`;
operator:>
times:.z.p
\

.gw.request:{[tab;syms;operator;times]
    / TODO
    / add start & end times
    servers: select w, host, user:.z.u, started:.z.p, finished:0Np, errored:0b, result:(::) from .gw.servers where not null w, (tabList~\:`) or tab in/: tabList, (symsList~\:`) or syms in/: symsList;

    if[not count servers; 'noServersAvailable];
    -30!(::);

    guid: first -1?0Ng;
    .gw.requests[guid]: enlist servers;

    query:(?;tab;();0b;());

    -25! (exec w from servers; (`.rdb.query; guid; query; `.gw.callback));
 };

.gw.callback:{[guid;err;res]
    / TODO
    / add res to .gw.requests
    / if all requests complete return to handle
 };

.gw.zpo:{[h]
    / TODO
 };

.gw.zpc:{[h]
    / TODO
 };
