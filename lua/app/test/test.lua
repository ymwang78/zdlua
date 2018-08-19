﻿local c = require "zce.core"
local lu = require('luaunit')

print(s)

_M = {}

function _M.test_me()

	c.log(1, "\t", "...........start...........", s)

	-- mempool 设置内置内存池，调节APP性能
	-- 特别是sharedata 存放的数据将从mempool取
	local ok = c.new_mempool(64, 10240)
	local ok = c.new_mempool(128, 10240)
	local ok = c.new_mempool(256, 10240)
	local ok = c.new_mempool(512, 10240)
	local ok = c.new_mempool(1024, 10240)

	local ok, tpool = c.new_threadpool(4)

	local ok, configdb = c.cache_init("local", "config")
	c.cache_set(configdb, 0, "mypool", tpool)
	
	local ok, rpcserv = c.rpc_serve("rpc", "0.0.0.0", 1217, "say_")
	lu.assertEquals( ok, true )

	c.new_service("test_lpcsvr1", "lua/app/test/test_rpc_server.lua", tpool)
	c.new_service("test_lpcsvr2", "lua/app/test/test_rpc_server.lua")

	c.new_service("test_lpccli1", "lua/app/test/test_rpc_client.lua", tpool, "test_lpcsvr1", 1217)
	c.new_service("test_lpccli2", "lua/app/test/test_rpc_client.lua", "test_lpcsvr2", 1217)
end

function _M.debug()

	c.new_service("test_sqlite", "lua/app/test/test_sqlite.lua")

	c.new_service("test_vmerr", "lua/app/test/test_vmerr.lua", tpool)

	c.new_service("", "lua/app/test/test_vmerr.lua", tpool)

	c.new_service("test_timer", "lua/app/test/test_timer.lua", tpool)

	c.new_service("", "lua/app/test/test_timer.lua", tpool)

	c.new_service("test_pgsql", "lua/app/test/test_pgsql.lua")
	
	c.new_service("", "lua/app/test/test_pgsql.lua")

	c.new_service("test_cache", "lua/app/test/test_cache.lua")

	c.new_service("", "lua/app/test/test_cache.lua")

	c.new_service("test_rawsvr", "lua/app/test/test_rawsocket_server.lua")
	
	c.new_service("test_rawcli", "lua/app/test/test_rawsocket_client.lua")

	c.new_service("", "lua/app/test/test_rawsocket_server.lua")

	c.new_service("", "lua/app/test/test_rawsocket_client.lua")

	-- c.new_service("test_storm", "lua/test/test_storm.lua", tpool)
	
	c.new_service("", "lua/app/test/test_storm.lua", tpool)

	c.new_service("test_lpcsvr", "lua/app/test/test_rpc_server.lua")

	c.new_service("test_lpccli", "lua/app/test/test_rpc_client.lua", tpool)

	c.new_service("", "lua/app/test/test_rpc_client.lua", tpool)

	c.new_service("test_pack", "lua/app/test/test_pack.lua")

	c.new_service("", "lua/app/test/test_pack.lua")

	-- c.new_service("test_httpsvr", "lua/app/test/test_http_server.lua")

    -- c.new_service("test_httpcli", "lua/app/test/test_http_client.lua")

	c.new_service("", "lua/app/test/test_http_server.lua")

    c.new_service("", "lua/app/test/test_http_client.lua")
	
	-- c.new_service("websvr", "lua/app/test/test_websocket_server.lua")

	-- c.new_service("test_cjson", "lua/app/test/test_cjson.lua", tpool)

	-- c.new_service("test_protobuf", "lua/app/test/test_protobuf.lua")
		
end

return _M;
