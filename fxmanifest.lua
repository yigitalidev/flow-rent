fx_version 'cerulean'
game 'gta5'

version '1.0.0beta'
lua54 'yes'

ui_page 'ui/index.html'

server_scripts {
    'server.lua',
}

client_scripts {
    'client.lua',
}

shared_scripts {
    'config.lua',
}

files {
    'ui/index.html',
    'ui/main.css',
    'ui/index.js',
    'ui/images/*.png',
    'ui/images/*.jpg',
    'ui/images/*.svg',
}