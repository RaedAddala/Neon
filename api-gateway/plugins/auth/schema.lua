local typedefs = require "kong.db.schema.typedefs"


local PLUGIN_NAME = "auth"


local schema = {
    name = PLUGIN_NAME,
    fields = {
        -- the 'fields' array is the top-level entry with fields defined by Kong
        { consumer = typedefs.no_consumer }, -- this plugin cannot be configured on a consumer (typical for auth plugins)
        { protocols = typedefs.protocols_http },
        {
            config = {
                -- The 'config' record is the custom part of the plugin schema
                type = "record",
                fields = {
                    -- a standard defined field (typedef), with some customizations
                    {
                        token_location = {
                            type = "string",
                            one_of = { "header", "query" },
                        }
                    },
                    {
                        public_key_path = {
                            type = "string",
                            required = true,
                            default = "/home/keys/public_key.pem"
                        }
                    },
                    {
                        allow_anonymous = {
                            type = "boolean",
                            required = true,
                            default = false
                        }
                    },
                    {
                        authorization_header = typedefs.header_name {
                            required = true,
                            default = "Authorization"
                        }
                    },
                    {
                        authorization_query_parameter = {
                            type = "string",
                            required = true,
                            default = "token"
                        }
                    },
                    {
                        id_header = typedefs.header_name {
                            required = true,
                            default = "X-Client-Id"
                        }
                    },
                    {
                        username_header = typedefs.header_name {
                            required = true,
                            default = "X-Client-Username"
                        }
                    },
                    {
                        id_query_parameter = {
                            type = "string",
                            required = true,
                            default = "id"
                        }
                    },
                    {
                        username_query_parameter = {
                            type = "string",
                            required = true,
                            default = "username"
                        }
                    }, -- adding a constraint for the value
                },
                entity_checks = {
                    -- add some validation rules across fields
                },
            },
        },
    },
}

return schema
