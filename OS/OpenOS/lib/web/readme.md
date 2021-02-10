# Web Internet simple library

How to use web

Example GET method:
```lua
local web = require("web")                                  -- include lib

local result = web.get("http://vk.com")                     -- return Content of GET METHOD
```
Example POST method:
```lua
local web = require("web")                                  -- include lib

local url = "http://testsite.com/api.php"                   -- url of request
local content = {["param1"]="test value"}                   -- POST contnet 
-- local contet = "<xml><count>5</count></xml>"             -- more use table/json(text)/xml(text)/text
local headers = {["user-agent"]="Wget/OpenComputers"}       -- headers of POST method

local result = web.post(url, content, headers)              -- return Content of GET METHOD
```
