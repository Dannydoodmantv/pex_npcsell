fx_version 'cerulean'
lua54'yes'
game 'gta5'

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua'
}

version '1.0.0'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

client_scripts {
    'client/client.lua'
}
