# OpenOS branch

### How to install lx loader
write in console:

     wget -f https://raw.githubusercontent.com/levshx/OpenComputers/main/OS/OpenOS/install/main.lua lxinstall.lua && lxinstall
     
### How to use lx
     
     lx help                 -- get all commands
     lx update               -- update cache (manifest program list)
     lx apps                 -- listen all installed apps
     lx install App_name     -- install app by app name
     lx del App_name         -- remove app by app name from computer
     lx upgrade App_name     -- update to latest version app by app name
     lx upgrade              -- update to latest version all apps
     lx show App_name        -- get all info by app name
     lx libs                 -- listen all installed libs 
     lx getlib Lib_name      -- get lib by lib name         
     lx dellib Lib_name      -- remove lib by lib name from computer
     lx reps                 -- listen all used reps
     lx addrep MANIFEST_url  -- add new repository by MANIFEST table URL
     lx delrep ID            -- remove repository
       
### Your rep MANIFEST example
see [MANIFEST](MANIFEST)

### Standart lx repository

list programs [bin](bin/)

list libraries [lib](lib/)
