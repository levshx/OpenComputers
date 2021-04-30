-- lib by levshx
-- web.get(url,headers) - WEB METHOD GET (return result)
-- web.post(url,dataTable,headers) - WEB METHOD POST (return result)
-- web.debug - WEB DEBUG OUTPUT PARAM (false default)

local web = {}
local internet = require("internet")
local url
local postData
local headers = {}
local method

web.debug = false  -- DEFAULT DEBUG LOG MODE

----------------------

function dataClear()             
  if web.debug then
    print("lib web.dataClear()")
  end
  url = nil
  postData = nil
  headers = {}
  method = nil
end

function webError(err)             
  if web.debug then
    print("lib web, error: "..err)
  end
end

local function requestNotSecure()    
  
  if web.debug then
    print("lib web.requestNotSecure("..url..")") 
  end
  
  local handle = internet.request(url,postData,headers,method)
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
  method = "GET"
  local status, result = xpcall(requestNotSecure,webError)
  if status then 
    return result
  else
    return nil
  end
  dataClear()
end

----------------------

--------[POST]--------

function web.post(postURL, tmpData, tmpHeaders) 
  
  if web.debug then
    print("lib web.post("..postURL..")")
  end
  
  url = postURL
  postData = tmpData
  headers = tmpHeaders
  method = "POST"
  local status, result = xpcall(requestNotSecure,webError)
  if status then 
    return result
  else
    return nil
  end
  dataClear()
end

----------------------


return web
