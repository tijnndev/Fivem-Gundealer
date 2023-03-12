fx_version 'bodacious'

game 'gta5'

description 'Wapendealer job'

version '0.0.1'

client_scripts {
    'client.lua',
    'config.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
    }

    ui_page 'html/index.html'

    files {
        'html/index.html',
        'html/assets/css/*.css',
        'html/assets/js/*.js',
        'html/assets/fonts/roboto/*.woff',
        'html/assets/fonts/roboto/*.woff2',
        'html/assets/fonts/justsignature/JustSignature.woff',
        'html/assets/images/*.png'
    }