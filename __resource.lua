----------------------------------------------------------------------
--      || $$$$$$$\            $$\   $$\            ||	--
--      || $$  __$$\           $$ |  $$ |           ||	--
--      || $$ |  $$ | $$$$$$\  \$$\ $$  | $$$$$$\   ||	--
--      || $$ |  $$ |$$  __$$\  \$$$$  / $$  __$$\  ||	--
--      || $$ |  $$ |$$$$$$$$ | $$  $$<  $$ /  $$ | ||	--
--      || $$ |  $$ |$$   ____|$$  /\$$\ $$ |  $$ | ||	--
--      || $$$$$$$  |\$$$$$$$\ $$ /  $$ |\$$$$$$  | ||	--
--      || \_______/  \_______|\__|  \__| \______/  ||	--
----------------------------------------------------------------------
--|               © 2022 DeXo, All rights reserved                  |--
-----------------------------------------------------------------------

fx_version 'cerulean'
game 'gta5'
lua54 'on'

author 'DeXo'

ui_page "nui/index.html"
files {
	"nui/index.html",
	"nui/style.css",
  "nui/fontcustom.woff",
  "nui/script.js",
}

client_scripts{ 
  "@vrp/client/Tunnel.lua",
  "@vrp/client/Proxy.lua",
  "config.lua",
  "client.lua",
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "config.lua",
  "server.lua"
}
