-- lib by levshx
-- web.get(url,headers)  - WEB GET  METHOD 
-- web.post(url,POST_TABLE,headers) - WEB POST METHOD

local web = {}
local internet = require("internet")
local url

function getError(err)             
  print("Fucking web error: "..err)
end
                  
local function getNotSecure()     
  --print("getNotSecure("..url..")") 
  local handle = internet.request(url)
  local result = ""
  for chunk in handle do 
    result = result..chunk 
  end
  return result
end

function web.get(getURL)          
  --print("get("..getURL..")")     
  url = getURL
  local status, result = xpcall(getNotSecure,getError)
  if status then 
    return result
  else
    return nil
  end
end


return web
