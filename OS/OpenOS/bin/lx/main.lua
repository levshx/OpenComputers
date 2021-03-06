-- Programms manager lx
local component = require("component")
local fs = require("filesystem")
local internet = require("internet")
local shell = require("shell")
local url = ""                     -- переменная для функции (костыль)

function getError(err)             -- вывод ошибки 
  print("Fucking error "..err)
end

local function getNotSecure()      -- функция гет запроса без обработки ошибок
  --print("getNotSecure("..url..")") -- debug mode
  local handle = internet.request(url)
  local result = ""
  for chunk in handle do 
    result = result..chunk 
  end
  return result
end

local function get(getURL)          -- функция с обёрткой, под обработку ошибки
  --print("get("..getURL..")")        -- debug mode
  url = getURL
  local status, result = xpcall(getNotSecure,getError)
  if status then 
    return result
  else
    return nil
  end
end


local args, options = shell.parse(...)

function help()
  local text = [[  lx help                 -- get all commands
  lx cache                -- update cache (manifest program list)
  lx apps                 -- listen all installed apps
  lx install App_name     -- install app by app name
  lx del App_name         -- remove app by app name from computer
  lx update App_name      -- update app by app name
  lx update               -- update all apps
  lx info App_name        -- get all info by app name
  lx libs                 -- listen all installed libs 
  lx getlib Lib_name      -- get lib by lib name         
  lx dellib Lib_name      -- remove lib by lib name from computer
  lx reps                 -- listen all used reps
  lx addrep MANIFEST_url  -- add new repository by MANIFEST table URL
  lx delrep               -- remove repository from computer]]
  print(text)  
end


if #args == 0 then
  print(" ===================")
  print(" |Software:  lx    |")
  print(" |Author:    levshx|")
  print(" |Year:      2021  |")
  print(" ===================")
  print("Commands:")
  help()
  return
elseif #args == 1 then
  if args[1] == "help" then
    help()
    return
  elseif args[1] == "cache" then
   
  elseif args[1] == "apps" then
  
  elseif args[1] == "update" then  
   
  elseif args[1] == "libs" then  
    
  elseif args[1] == "reps" then  
  
  else
    print(" Bad arguments, use:")
    help()
  end
elseif #args == 2 then  
  
else
  help()  
end
