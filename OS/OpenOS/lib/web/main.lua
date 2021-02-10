-- lib by levshx
-- web.get(url,headers) - WEB METHOD GET (return result)
-- web.post(url,dataTable,headers) - WEB METHOD POST (return result)
-- web.debug - WEB DEBUG OUTPUT PARAM (false default)

local web = {}
local internet = require("internet")
local url
local postData = {}
local headers 

web.debug = false  -- DEFAULT DEBUG LOG MODE

----------------------

function dataClear()             
  if web.debug then
    print("lib web.dataClear()")
  end
  url = nil
  postData = {}
  headers = nil
end

function webError(err)             
  if web.debug then
    print("lib web.lua Fucking web error: "..err)
  end
end

local function getNotSecure()    
  
  if web.debug then
    print("lib web.getNotSecure("..url..") -- ") 
  end
  
  local handle = internet.request(url)
  local result = ""
  for chunk in handle do 
    result = result..chunk 
  end
  return result
end


--------[GET]--------

function web.get(getURL) 
  
  if web.debug then
    print("lib web.get("..getURL..")")
  end
  
  url = getURL
  local status, result = xpcall(getNotSecure,webError)
  if status then 
    return result
  else
    return nil
  end
end

----------------------


return web
