U=${MCP_URL:?set MCP_URL to your Xano MCP server stream URL}
call(){ curl -s -H Content-Type:application/json -H Accept:application/json,text/event-stream -X POST $U -d "{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"tools/call\",\"params\":{\"name\":\"$1\",\"arguments\":$2}}" | grep '^data' | cut -c7- ; }
call add_lead '{"name":"Sam Okafor","company":"Harbor Labs","deal_value":3100}' >/dev/null
call add_lead '{"name":"Leo Park","company":"Brightline Dental","deal_value":2200,"stage":"Qualified"}' >/dev/null
call add_lead '{"name":"Ana Ruiz","company":"Kiln & Co","deal_value":6500,"stage":"Won"}' | python3 -c "import sys,json;d=json.load(sys.stdin);b=json.loads(d['result']['content'][0]['text']);print([(l['name'],l['stage']) for l in b['leads']])"
