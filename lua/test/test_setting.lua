local _M = {
    siteid = "test",

    threadpool = {
        num = 4,
        tpoolobj = nil,
    },

    mempool = {
        {64, 10240},
        {128, 10240},
        {256, 10240},
        {512, 10240},
        {1024, 10240},
        {4096, 10240},
    },

    pgsqldb = {
        host = "pgsql.svr",
        port = 3300,
        user = "zhidup",
        pass = "pwdzhidurl",
        name = "hawk",
    },

    redisdb = {
        host = "redis.svr",
        port = 6379,
        pass = "f7743905699f4320:PwdZhiduR0",    
    },

    package = {
        cache = "redis", -- could be '', "redis", "local"
        cacheobj = nil,
    },
}

return _M