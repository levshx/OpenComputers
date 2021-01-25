local robot = require("robot")
local component = require("component")
local sides = require("sides")
local inventory = component.inventory_controller
 
local AXE_NAME = "ThaumicTinkerer:ichorAxeGem"
local HOE_NAME = "EMT:ElectricHoeGrowth"
local SAPLING_NAME = "minecraft:sapling"

 
local function equipItem(name)
    local emptySlot = 0
    for i = 1, robot.inventorySize() do
        if not inventory.getStackInInternalSlot(i) then
            emptySlot = i
            goto next
        end
    end
 
    :: next ::
 
    if emptySlot ~= 0 then
        robot.select(emptySlot)
        inventory.equip()
    else
        print("Can't find empty slot for sorting")
        goto finish
    end
 
    for i = 1, robot.inventorySize() do
        local item = inventory.getStackInInternalSlot(i)
        if item and item.name and item.name == name then
            robot.select(i)
            inventory.equip()
            goto finish
        end
    end
 
    :: finish ::
end
 
local function unload()
 
    robot.turnLeft()
    local saplingsDetected = false
    for i = 1, robot.inventorySize() do
        local item = inventory.getStackInInternalSlot(i)
        if item then
            if item.name and item.name == AXE_NAME then
                goto continue
            elseif item.name and item.name == HOE_NAME then
                goto continue
            elseif item.label and item.name == SAPLING_NAME and saplingsDetected == false then
                saplingsDetected = true
                goto continue
            else
 
                robot.select(i)
                inventory.dropIntoSlot(sides.front, i)
            end
        end
 
        :: continue ::
    end
 
    robot.turnRight()
end
 
local function charge()
 
    local hoeSlot = -1
    for i = 1, robot.inventorySize() do
        local item = inventory.getStackInInternalSlot(i)
        if item and item.name and item.name == HOE_NAME and item.charge and item.charge <= 2000 then
            hoeSlot = i
            goto charge
        end
    end
 
    :: charge ::
 
    if hoeSlot ~= -1 then
        robot.turnRight()
 
        print("hoe charging started")
        robot.select(hoeSlot)
        inventory.dropIntoSlot(sides.front, 1)
        os.sleep(15)
        inventory.suckFromSlot(sides.front, 1)
        print("hoe charging finished")
 
        robot.turnLeft()
    end
 
end
 
local function safeMovement(func)
    local result, reason = func()
    while not result do
        print(result, result)
        result, reason = func()
    end
end
 
local function plantSapling()
    equipItem(SAPLING_NAME)
 
    safeMovement(robot.up)
    safeMovement(robot.forward)
    robot.useDown()
    safeMovement(robot.back)
    safeMovement(robot.down)
    print("========================")
end
 
local function growSapling()
    equipItem(HOE_NAME)
 
    for i = 1, 10 do
        robot.use(sides.front)
        os.sleep(0.2)
    end
end
 
local function chopSapling()
    equipItem(AXE_NAME)
 
    robot.swing()
    os.sleep(0.2)
end
 
local function suckItems()
    os.sleep(10)
    robot.suck()
    robot.suckUp()
end
 
while true do
    unload()
    charge()
    plantSapling()
    growSapling()
    chopSapling()
    suckItems()
end
