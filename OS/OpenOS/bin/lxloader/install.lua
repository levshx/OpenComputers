local shell = require("shell")
local fs = require("filesystem")
local term = require("term")

fs.makeDirectory("/usr/lib")
if fs.exists("/usr/lib/lx.lua") then
  fs.remove("/usr/lib/lx.lua")
end

-- start

print("START")

-- download app lx.lua
fs.makeDirectory("/usr/bin")
if fs.exists("/usr/bin/lx.lua") then
  fs.remove("/usr/bin/lx.lua")
end
print("GET APP lx.lua   ")
shell.execute("wget -f https://raw.githubusercontent.com/levshx/OpenComputers/main/OS/OpenOS/bin/lxloader/main.lua /usr/bin/lx.lua")
os.sleep(4)

-- make Dirictory /etc/lx/
print("MAKE LX DIRICTORIES  ")
fs.makeDirectory("/etc/lx")
os.sleep(1)

-- Download rep CONFIG
print("GET REPOSITORY CONFIG")
shell.execute("wget -f URL /etc/lx/rep_list")
os.sleep(2)

-- Download standart rep MANIFEST
print("GET STANDART APP LIST")
shell.execute("lx cache")
os.sleep(4)

-- finish
print("Complete")
os.sleep(0.5)
print("lx app was installed")
shell.execute("del lxinstall.lua")
