-- by levshx
local component = require("component")
local gpu = component.gpu
local term = require("term")
local fs = require("filesystem")  
local serialization = require("serialization") 
local TIME_ZONE = 3
local reactor
local rs
local t_correction = TIME_ZONE * 3600 

--LX Library
if not fs.exists("/lib/lx.lua") then
  print("Скачивание lx.lua - графической библиотеки levshx")
  shell.execute("pastebin get SaGg3cGq /lib/lx.lua")
end

term.clear()
local selectedSideInput
local inventorySize = 0
local work = false
local maxHeat = 0

print("Start software (desc. by levshx)")

os.sleep(3)

sides = {}
sides[1] = "down"
sides[2] = "up"
sides[3] = "north"
sides[4] = "south"
sides[5] = "west"
sides[6] = "east"


if (component.isAvailable("reactor") or component.isAvailable("reactor_chamber")) then
  print("Reactor is active (nice)")
  if component.isAvailable("reactor") then
    reactor = component.reactor
  end
  if component.isAvailable("reactor_chamber") then
    reactor = component.reactor_chamber
  end 
  os.sleep(1)
else
  print("component Reactor is not active (bad)")
  error("СУКА подключи реактор адаптером")
end

if component.isAvailable("redstone") then
  print("Redstone is active (nice)")
  rs = component.redstone
else
  print("component Redstone not found (bad)")
  error("СУКА подключи к реактору: Красный камень (ввод/вывод) [837:0]")
end

function rsAll(value)
  rs.setOutput(0, value)
  rs.setOutput(1, value)
  rs.setOutput(2, value)
  rs.setOutput(3, value)
  rs.setOutput(4, value)
  rs.setOutput(5, value)
end

rsAll(0)

os.sleep(2)

while true do
  term.clear()
  print("Установите сундук со стержнями, вплотную к краю реактора.")
  print("Укажите с какой стороны от реактора находится сундук:")
  print("1. Снизу")
  print("2. Сверху")
  print("3. С севера")
  print("4. С юга")
  print("5. С запада")
  print("6. С востока")
  term.write("Введите цифру пункта: ")
  inputValue = term.read()
  inputValue = inputValue+0
  if (inputValue>0 and inputValue<6) then
    print("Ответ синхронизирован") 
    os.sleep(1)
    selectedSideInput = sides[inputValue]
    print("Selected side: "..selectedSideInput) 
    os.sleep(1)  
    break
  else
    print("Хуёвый ответ :(")
    os.sleep(1)
    term.clear()
  end
end

print("")
term.write("Введите кол-во ячеек сундука который вы установили к реатору: ")
inventorySize = inventorySize + term.read()

print("Inventory size: "..inventorySize)
print("")
print("Топим за безопасность")
term.write("Введите максимальную температуру реактора (для его выключения) (8500 збс): ")
maxHeat = maxHeat + term.read()

print("Max Heat: "..maxHeat)


function getHostTime(timezone) --Получить текущее реальное время компьютера, хостящего сервер майна
  timezone = timezone or 2
  local file = io.open("/HostTime.tmp", "w")
  file:write("123")
  file:close()
  local timeCorrection = timezone * 3600
  local lastModified = tonumber(string.sub(fs.lastModified("/HostTime.tmp"), 1, -4)) + timeCorrection
  fs.remove("HostTime.tmp")
  local year, month, day, hour, minute, second = os.date("%Y", lastModified), os.date("%m", lastModified), os.date("%d", lastModified), os.date("%H", lastModified), os.date("%M", lastModified), os.date("%S", lastModified)
  return tonumber(day), tonumber(month), tonumber(year), tonumber(hour), tonumber(minute), tonumber(second)
end


function time(timezone) --Получет настоящее время, стоящее на Хост-машине
  local time = {getHostTime(timezone)}
  local text = string.format("%02d:%02d:%02d", time[4], time[5], time[6])
  return text
end

os.sleep(1)
print("Start work ...")
os.sleep(1)
term.clear()

function secury()
  if (reactor.getHeat() < maxHeat) then
    rsAll(15)
    if (not work) then
      work = true
      print("Reactor start        ",time(3))
    end 
  else
    rsAll(0)
    if  work then
      work = false
      print("Reactor stop [by heat]",time(3))
    end 
  end
end


print("------------- WORK -------------")

while true do
  for i = 1, reactor.getInventorySize()-4 do  
    if (reactor.getStackInSlot(i) == nil) then
      rsAll(0)      
      os.sleep(7)      
      work = false
      print("Reactor stop [pulling]",time(3))
      for j = 1, inventorySize do
      	reactor.pullItemIntoSlot(selectedSideInput,j,64,i)
      	reactor.pullItemIntoSlot(selectedSideInput,j,64,i)
      end 
      print("Slot ["..i.."] was pulled",time(3))
      secury()
    else
      secury()
      -- когда слот занят
    end    
  end
  secury() 
  os.sleep(1) 
end
