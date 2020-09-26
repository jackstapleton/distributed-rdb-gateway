
\c 30 230
\e 1

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
.gw.requests:()!();
\

.gw.requests: flip `guid`rdbHandle`userHandle`user`started`finished`errored`result!();
`.gw.requests upsert (0Ng; 0Ni; 0Ni; `; 0Np; 0Np; 0b; ());

.gw.register:{[tabs;syms]
    / TODO
    / add start & end times
    `.gw.servers upsert (.z.p; .z.w; .z.h; tabs; syms);
 };

.gw.query:{[tab;syms;query]
    / TODO
    / parse queries here
    / figure out what to send to rdb
    / tab & syms sent down to filter rdbs
    -30!(::);
    .gw.request[.z.w;tab;syms;query]
 };

.gw.test:{ .gw.request[8i;`trade;`;(?;`trade;();0b;())] }

.gw.request:{[h;tab;syms;query]
    / TODO
    / add start & end times
    id: first -1?0Ng;
    servers: select guid:id, rdbHandle:w, userHandle:h, user:.z.u,
                    started:.z.p, finished:0Np, errored:0b, result:(::)
                    from .gw.servers where not null w,
                                           (tabList~\:`) or tab in/: tabList,
                                           (symsList~\:`) or syms in/: symsList;

    if[not count servers;
            -30!(h; 1b; "noServersAvailable") ];

    `.gw.requests upsert servers;

    -25! (exec rdbHandle from servers; (`.rdb.query; id; query; `.gw.callback));
 };

.gw.callback:{[id;err;res]
    update finished:.z.p, errored:err, result:enlist res from `.gw.requests where rdbHandle=.z.w, guid=id;
    if[all not null exec finished from .gw.requests where guid=id;
            .gw.return[id];
            delete from `.gw.requests where guid=id ];
 };

.gw.return:{[id]
    -30!(exec first userHandle from .gw.requests where guid=id;
        err;
        $[err:exec any errored from .gw.requests where guid=id;
            "\n" sv exec result from .gw.requests where guid=id, errored;
            .gw.compile id ])
    };


.gw.compile:{[id]
    `time xasc exec raze result from .gw.requests where guid=id
 };


.gw.zpo:{[h]
    / TODO
    / just log ?
 };

.gw.zpc:{[h]
    delete from `.gw.servers where w=h;
    update errored:1b, result:enlist "rdb disconnected" from `.gw.requests where rdbHandle=h, not null finished;
    delete from `.gw.requests where userHandle=h;
 };

.gw.zts:{[]
    / TODO
    / check for any long running queries
    / check size of requests tab ?
 };
