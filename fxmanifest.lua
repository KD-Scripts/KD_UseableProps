fx_version 'adamant'
game 'gta5'
lua54 'yes'

author 'Kokkachi Damu#5646'

client_script {
    'client.lua'
}

server_scripts {
    'server.lua'
}

shared_script {
    'config.lua',
    'edit.lua'
}

escrow_ignore {
    'config.lua',
    'edit.lua'
}

files {

    'stream/*.ydr',
    'stream/*.ytd',
    'stream/*.ytyp',
}

data_file 'DLC_ITYP_REQUEST' 'stream/*.ytyp'