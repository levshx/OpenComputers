local robot = require("robot")
local component = require("component")
local i_c = component.inventory_controller
local sides = require("sides")
local term = require("term")
 
term.clear()
 
print("LEVSHX SOFTWARE")
 
function dropRES()
local i = 1
robot.turnLeft()
for i=1, 16 do
robot.select(i)
i_c.dropIntoSlot(sides.front, i )
end
robot.turnRight()
robot.select(1)
end
 
function takeRES()
robot.turnAround()
local inv, item = i_c.getInventorySize(sides.front)
for slot = 1, inv do
item = i_c.getStackInSlot(sides.front, slot)
if item then
i_c.suckFromSlot(sides.front, slot)
break
end
end
robot.turnAround()
end
 
function workRES()
robot.select(1)
local items_count = robot.count(1)
for i=1, items_count do
robot.place()
robot.swing()
end
end
 
while true do
takeRES()
workRES()
dropRES()
term.clear()
print("")
print("")
print("")
print("")
print("               LEVSHX SOFTWARE")
print("")
print("")
print("        Press Ctrl+Alt+C for exit program")
os.sleep(1)
term.clear()
print("")
print("")
print("")
print("")
print("               LEVSHX SOFTWARE                     ")
print("")
print("")
print("           Robot working ... wait")
end
