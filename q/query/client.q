
.client.open:{ while[null .client.GW: @[{hopen (first `::5050,`$x; 5000)}; .Q.opt[.z.x][`gw]; 0Ni]] };
.client.open[];

.z.pc:{ if[x=.client.GW; .client.open[] ] }

x: .client.GW @ ({.gw.query[`trade;`;(?;`trade;();0b;())]};`)
