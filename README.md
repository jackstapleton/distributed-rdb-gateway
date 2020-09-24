# distributed-rdb-gateway
gateway to query distributed RDBs

## TODO

### gateway

#### qw.q

create a register function (put rdbs in rdb table)

intercept queries
1. just do an api for tables, times and sym
2. parse selects just for the where clause
3. parse the by clauses

query comes in, run -30!(::)

have a query table
send queries async

when all rdbs have returned with callback
join and return to user with -30!(8i;0b;result)

### rdb

#### r.q

comes up connects to gateway with register func
run query, send result back in a callback function

### test

2 csvs trade, quote table
text file with queries

no tickerplant

1 regular rdb all data

1 gateway, 3 rdbs, split data

query process that returns the same data from rdb and gateway

### aws

can take cloudformation add a gateway rdb-autoscaling
ami and install script also
add gateway
