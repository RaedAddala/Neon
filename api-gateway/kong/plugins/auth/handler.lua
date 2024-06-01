-- If you're not sure your plugin is executing, uncomment the line below and restart Kong
-- then it will throw an error which indicates the plugin is being loaded at least.

--assert(ngx.get_phase() == "timer", "The world is coming to an end!")

---------------------------------------------------------------------------------------------
-- In the code below, just remove the opening brackets; `[[` to enable a specific handler
--
-- The handlers are based on the OpenResty handlers, see the OpenResty docs for details
-- on when exactly they are invoked and what limitations each handler has.
---------------------------------------------------------------------------------------------

local plugin = {
    PRIORITY = 1000,   -- set the plugin priority, which determines plugin execution order
    VERSION = "0.1.0", -- version in X.Y.Z format. Check hybrid-mode compatibility requirements.
}

-- do initialization here, any module level code runs in the 'init_by_lua_block',
-- before worker processes are forked. So anything you add here will run once,
-- but be available in all workers.

local jwt = require "resty.jwt"
-- local cjson = require "cjson"
-- ngx.log(ngx.DEBUG, "res.access_token.sub=", cjson.encode(jwt_obj))

local errors = {
    [401] = {
        ["status"] = "401",
        ['error'] = "Unauthorized"
    },
    [500] = {
        ["status"] = "500",
        ['error'] = "Internal server error"
    }
}

local function get_public_key(plugin_conf)
    local public_key_path = plugin_conf.public_key_path

    local f = io.open(public_key_path, "r")

    if (f == nil) then
        return nil
    end

    local t = f:read("*all")
    f:close()

    return t
end

local function clear_headers(plugin_conf)
    kong.service.request.clear_header(plugin_conf.id_header)
    kong.service.request.clear_header(plugin_conf.username_header)
end

local function clear_query(plugin_conf)
    local query = kong.request.get_query()

    query[plugin_conf.id_query_parameter] = nil
    query[plugin_conf.username_query_parameter] = nil

    kong.service.request.set_query(query)
end

local function get_token_from_header(plugin_conf)
    local authorization_header = kong.request.get_header(plugin_conf.authorization_header)

    if (authorization_header == nil) then
        return nil
    end

    local data = {}

    for k, v in string.gmatch(authorization_header, "(.+)%s(.+)") do
        data[k] = v
        break
    end

    local type, token = next(data)

    if (type ~= "Bearer") then
        return nil
    end

    return token
end

local function handle_header_token(plugin_conf, key, token)
    local jwt_obj = jwt:verify(key, token)

    if (jwt_obj == nil) then
        if (not plugin_conf.allow_anonymous) then
            return kong.response.exit(401, errors[401])
        end

        clear_headers(plugin_conf)

        return clear_query(plugin_conf)
    end

    local payload = jwt_obj["payload"]

    kong.service.request.set_header(plugin_conf.id_header, payload["sub"])
    kong.service.request.set_header(plugin_conf.username_header, payload["username"])
end

local function get_token_from_query(plugin_conf)
    return kong.request.get_query_arg(plugin_conf.authorization_query_parameter)
end

local function handle_query_token(plugin_conf, key, token)
    local jwt_obj = jwt:verify(key, token)

    if (jwt_obj == nil) then
        if (not plugin_conf.allow_anonymous) then
            return kong.response.exit(401, errors[401])
        end

        clear_headers(plugin_conf)

        return clear_query(plugin_conf)
    end

    local payload = jwt_obj["payload"]

    local query = kong.request.get_query()

    query[plugin_conf.id_query_parameter] = payload["sub"]
    query[plugin_conf.username_query_parameter] = payload["username"]

    kong.service.request.set_query(query)
end

-- handles more initialization, but AFTER the worker process has been forked/created.
-- It runs in the 'init_worker_by_lua_block'
function plugin:init_worker()
    kong.log.debug("auth plugin started")
end

-- runs in the 'access_by_lua_block'
function plugin:access(plugin_conf)
    local public_key = get_public_key(plugin_conf)

    if (public_key == nil) then
        return kong.response.exit(500, errors[500])
    end

    if (plugin_conf.token_location == nil or plugin_conf.token_location == "header") then
        local header_token = get_token_from_header(plugin_conf)

        if (header_token ~= nil) then
            return handle_header_token(plugin_conf, public_key, header_token)
        end
    end

    if (plugin_conf.token_location == nil or plugin_conf.token_location == "query") then
        local query_token = get_token_from_query(plugin_conf)

        if (query_token ~= nil) then
            return handle_query_token(plugin_conf, public_key, query_token)
        end
    end

    if (not plugin_conf.allow_anonymous) then
        return kong.response.exit(401, errors[401])
    end
end

-- return our plugin object
return plugin
