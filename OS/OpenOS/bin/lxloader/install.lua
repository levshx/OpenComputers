local shell = require("shell")
local fs = require("filesystem")
local term = require("term")
term.clear()
print("Downlodading library lx.lua")
shell.execute("wget -f https://raw.githubusercontent.com/levshx/OpenComputers/main/OS/OpenOS/lib/lx/main.lua /usr/lib/lx.lua")
local lx = require("lx")
term.clear()
lx.loading(5,"START")
lx.logo("center")
os.sleep(1)
lx.loading(20,"GET APP lx.lua")
shell.execute("wget -f https://raw.githubusercontent.com/levshx/OpenComputers/main/OS/OpenOS/bin/lxloader/main.lua /usr/bin/lx.lua")
term.clear()
lx.logo("center")
lx.loading(20,"MAKE LX DIRICTORIES")
os.sleep(1)
fs.makeDirectory("/etc/lx/")
