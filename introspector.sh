#!/bin/bash
#!/bin/bash
A="https://dev.libremfg.ai"
B="http://localhost"

#URL ENDPOINTS
CORE=":4002/query"
SCHEDULER=":10001/query"
WMS=":10001/query"
DGRAPH=":8080/admin"


rover subgraph introspect ${A}${CORE} > subgraphs/${A}.CORE.graphql
rover subgraph introspect ${A}${SCHEDULER} > subgraphs/${A}.SCHEDULER.graphql
rover subgraph introspect ${A}${WMS} > subgraphs/${A}.WMS.graphql

curl \
-X POST \
-H "Content-Type: application/json" \
--data  '{"query":"query Query {\n  getGQLSchema {\n    generatedSchema\n  }\n}\n","variables":{}}' \
${A}${DGRAPH} | jq -r  '.data.getGQLSchema.generatedSchema' > subgraphs/${A}.DGRAPH.graphql


rover subgraph introspect ${B}${CORE} > subgraphs/${B}.CORE.graphql
rover subgraph introspect ${B}${SCHEDULER} > subgraphs${B}.SCHEDULER.graphql
rover subgraph introspect ${B}${WMS} > subgraphs/${B}.WMS.graphql

curl \
-X POST \
-H "Content-Type: application/json" \
--data  '{"query":"query Query {\n  getGQLSchema {\n    generatedSchema\n  }\n}\n","variables":{}}' \
 ${B}${DGRAPH}  | jq -r  '.data.getGQLSchema.generatedSchema' > subgraphs/${B}.DGRAPH.graphql
