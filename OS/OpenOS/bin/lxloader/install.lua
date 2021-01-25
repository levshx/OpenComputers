local shell = require("shell")
local fs = require("filesystem")
local term = require("term")
term.clear()
print("Downlodading library lx.lua")
shell.execute("wget -f https://raw.githubusercontent.com/levshx/OpenComputers/main/OS/OpenOS/lib/lx/main.lua /usr/lib/lx.lua")
local lx = require("lx")

-- start
term.clear()
lx.logo("center")
lx.loading(5,"START             ")

-- download app lx.lua
os.sleep(1)
shell.execute("wget -f https://raw.githubusercontent.com/levshx/OpenComputers/main/OS/OpenOS/bin/lxloader/main.lua /usr/bin/lx.lua")
lx.loading(50,"GET APP lx.lua   ")
os.sleep(4)

-- make Dirictory /etc/lx/
term.clear()
lx.logo("center")
lx.loading(55,"MAKE LX DIRICTORIES  ")
fs.makeDirectory("/etc/lx/")
os.sleep(1)

-- Download rep CONFIG
term.clear()
lx.logo("center")
lx.loading(75,"GET REPOSITORY CONFIG")
shell.execute("wget -f URL /etc/lx/rep_list")
os.sleep(2)

-- Download standart rep MANIFEST
term.clear()
lx.logo("center")
lx.loading(65,"GET STANDART APP LIST")
shell.execute("lx cache")
os.sleep(4)

-- start
term.clear()
lx.logo("center")
lx.loading(100,"Complete")
os.sleep(3)
term.clear()
print("Try: lx help")
