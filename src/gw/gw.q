/- we should add a connectTime and initialize time . 
/- As the rdb will be up for awhile prior to receiving data 

/- are all tables and all symbols not going to all rdbs ? 
/- we should add a coupe of times 
/- 1.warm up time 
/- 2. first upd message  (have an initial rdb upd function then after first upd message assign back to old upd )
/- 3. last upd ( sent from rdb when tp closes rdb handle)
/- .gw.servers: flip `time`handle`host`ip`tabs`syms`procType`procName`warmTime`tsFirstMessage`tsLastMessage!();
/- `.gw.servers upsert (0Np;0Ni;`;`;();();`;`;0Np;0Np;0Np);


.gw.servers: flip `time`handle`host`ip`tabs`syms`procType`procName!();
`.gw.servers upsert (0Np;0Ni;`;`;();();`;`);

/- this should just track user requests
.gw.requests: flip `recievedTime`guid`userHandle`request!();
`.gw.requests upsert (0Np;0Ng;0Ni;());

.gw.dataRequestsHist:0!.gw.dataRequests:2!flip `guid`rdbHandle`request`sent`res`response`error`time!();
`.gw.dataRequests`.gw.dataRequestsHist upsert\: (0Ng;0Ni;();"b"$();();"b"$();();0Np)

/- function called after rdb initializes connection
.gw.register:{[host;ip;tabs;syms;procType;procName]
    / add rdb to .gw.servers
    `.gw.servers upsert (.z.p;.z.w;host;ip;tabs;syms;procType;procName)
 };

.gw.request:{[tab;syms;func;st;et]
    / use deferred sync
    -30!(::);
    /- assign random guid - use deal -1?
    guid:first -1?0Ng;
    / add request to .gw.requests
    request:(func;tab;syms;st;et;guid);
    / send a query to each rdb
    handles:.gw.getRdbHandles[tab;syms;st;et];
    `.gw.requests upsert (.z.p;guid;.z.w;request);
    `.gw.dataRequests`.gw.dataRequestsHist upsert/: (guid;;request;0b;0Np;();0b;0Np;();.z.p) each handles;
    neg[handles]@\:request;
    {![x;enlist (=;`guid;enlist y);0b;`time`sent!(.z.p;1b)]} [;guid] each `.gw.dataRequests`.gw.dataRequestsHist;

 };

.gw.getRdbHandles:{[]
	\- find rdb handles that atch teh request using the tab/st/et input
	/- we should be able to know exactly which handles to send request
	/- if rdbs split by sym then the syms input will hel further
	/- check .gw.servers tab for first and last upd message 
	/- for now just find all handles
	/- might need load balancing - one rdb could be busy 
	exec handle from `gw.servers where procType=`rdb
 };

.gw.callback:{[guid;res]
    / add res to .gw.requests
    / if all requests complete return to handle
    / combine all requests if a requests are returned
    request:first exec request from .gw.dataRequests where guid=guid
    if[null request;:()];
    `.gw.dataRequests`.gw.dataRequestsHist upsert/: upsert (guid;.z.w;request;1b;res[0];1b;err:res[1];.z.p);
    if[err;
    	send to client;
    	delete all other requests;]

    /- check if all request have 1b response
    /- if so conolidate results
 };

 
