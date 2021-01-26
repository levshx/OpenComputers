-- lib by levshx
-- include SkyDrive_ lib

local lx = {}
local component = require("component")
local computer=require("computer")
local serial = require("serialization")
local term = require("term")
local event = require("event")
local unicode = require("unicode")
local fs = require("filesystem")
local internet = require("internet")
local gpu = component.gpu
local version = 4 

function lx.box()
  local xScreen,yScreen = gpu.getResolution()
  gpu.fill(1, 1, xScreen, 1, unicode.char(0x2836)) -- верхняя горизонтальная
  gpu.fill(1, yScreen, xScreen, 1, unicode.char(0x2836))  -- нижняя горизонтальная
  gpu.fill(1,1,1,yScreen,unicode.char(0x2588))  -- левая вертикальная
  gpu.fill(xScreen,1,1,yScreen,unicode.char(0x2588)) -- правая вертикальная
  gpu.set(1, 1, unicode.char(0x28f6)) -- левый верхний
  gpu.set(xScreen, 1, unicode.char(0x28f6)) -- правый верхний
  gpu.set(1, yScreen, unicode.char(0x283f)) -- левый нижний
  gpu.set(xScreen, yScreen, unicode.char(0x283f)) -- правый нижний
end

function lx.loading(procent,name)
  local xScreen,yScreen = gpu.getResolution()  
  gpu.fill(1, yScreen-1, math.modf((xScreen/100)*procent), 1, unicode.char(0x2588))
  gpu.set(1,yScreen,name)
end

function lx.logo(alignment, x, y) --вывод logo  
  local xScreen,yScreen = gpu.getResolution()
  local logo = {}
  logo[1]="██╗░░░░░███████╗██╗░░░██╗░██████╗██╗░░██╗██╗░░██╗"
  logo[2]="██║░░░░░██╔════╝██║░░░██║██╔════╝██║░░██║╚██╗██╔╝"
  logo[3]="██║░░░░░█████╗░░╚██╗░██╔╝╚█████╗░███████║░╚███╔╝░"
  logo[4]="██║░░░░░██╔══╝░░░╚████╔╝░░╚═══██╗██╔══██║░██╔██╗░"
  logo[5]="███████╗███████╗░░╚██╔╝░░██████╔╝██║░░██║██╔╝╚██╗"
  logo[6]="╚══════╝╚══════╝░░░╚═╝░░░╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝"
  logo[7]="                 levshx™ software                "
  -- x-25
  -- y-3
  if alignment == "center" then
    for i = 1, #logo do
      gpu.set((math.modf(xScreen/2)-25),(math.modf(yScreen/2)-3)+i,logo[i])
    end
  else 
    if alignment == nil then
      for i = 1, #logo do
        gpu.set(x,y+i,logo[i])
      end
    end     
  end
end


function lx.com(command) --Командный блок    
  if (component.isAvailable("opencb")) then
    local _,c = component.opencb.execute(command)
    return c
  else
    return nil
  end
end
 
function lx.money(nick) --Баланс игрока 
  local c = lx.com("money " .. nick)
  local _, b = string.find(c, "Баланс: §f")
  local balance
  if b == nil then 
    balance = "0.00"
  elseif string.find(c, "Emeralds") ~= nil then
    balance = unicode.sub(c, b - 16, unicode.len(c) - 10)
  else
    balance = unicode.sub(c, b - 16, unicode.len(c) - 9)
  end  
  return (balance)
end


function lx.checkMoney(nick,price) --Чекнуть, баланс, если хватает, то снять бабки
  local balance = lx.money(nick)
  balance = string.sub(balance, 1, string.len(balance) - 3)
  if string.find(balance, "-") ~= nil then
    return false
  else
    balance = string.gsub(balance,",","")
    if tonumber(balance) < price then
      return false
    else
      lx.com("money take " .. nick .. " " .. price)
      return true
    end
  end
end

function lx.takeItem(nick, item, numb) --Забрать итем
  if string.find(lx.com("clear " .. nick .. " " .. item .. " " .. numb), "Убрано") ~= nil then
    return true
  else
    return false
  end
end

function lx.giveItem(nick, item, numb) --Выдать предмет и чекнуть влезло ли в инвентарь, если нет, вернуть остаток
  local text = lx.com("egive " .. nick .. " " .. item .. " " .. numb)

  if string.find(text, "Недостаточно свободного места") ~= nil then
    local _, b = string.find(text, "Недостаточно свободного места, §c")
    
    local i = 0
    local ostatok = ""
    while (ostatok ~= " ") do
      i = i + 1
      ostatok = string.sub(text, b+i, b+i)
    end
    ostatok = string.sub(text, b+1, b+i-1)
    ostatok = string.gsub(ostatok,",","")
    return ostatok
  else
    return 0
  end
end


function lx.setColor(index) --Список цветов
  if (index ~= "r") then back = gpu.getForeground() end
  if (index == "0") then gpu.setForeground(0x333333) end
  if (index == "1") then gpu.setForeground(0x0000ff) end
  if (index == "2") then gpu.setForeground(0x00ff00) end
  if (index == "3") then gpu.setForeground(0x24b3a7) end
  if (index == "4") then gpu.setForeground(0xff0000) end
  if (index == "5") then gpu.setForeground(0x8b00ff) end
  if (index == "6") then gpu.setForeground(0xffa500) end
  if (index == "7") then gpu.setForeground(0xbbbbbb) end
  if (index == "8") then gpu.setForeground(0x808080) end
  if (index == "9") then gpu.setForeground(0x0000ff) end
  if (index == "a") then gpu.setForeground(0x66ff66) end
  if (index == "b") then gpu.setForeground(0x00ffff) end
  if (index == "c") then gpu.setForeground(0xff6347) end
  if (index == "d") then gpu.setForeground(0xff00ff) end
  if (index == "e") then gpu.setForeground(0xffff00) end
  if (index == "f") then gpu.setForeground(0xffffff) end
  if (index == "g") then gpu.setForeground(0x00ff00) end
  if (index == "r") then gpu.setForeground(back) end
end

function lx.text(x,y,text) --Цветной текст
  local n = 1
  for i = 1, unicode.len(text) do
    if unicode.sub(text, i,i) == "&" then
      lx.setColor(unicode.sub(text, i + 1, i + 1))
    elseif unicode.sub(text, i - 1, i - 1) ~= "&" then
      gpu.set(x+n,y, unicode.sub(text, i,i))
      n = n + 1
    end
  end
end

function lx.checkOP(nick) --Чек на опку
  local c = lx.com("whois " .. nick)
  local _, b = string.find(c, "OP:§r ")
  local text = string.sub(c, b+1, string.find(c, "Режим полета:"))
  if string.find(text, "§aистина§r") ~= nil then
    return true
  else
    return false
  end
end

function lx.playtime(nick) --Плейтайм
  local c = lx.com("playtime " .. nick)
  local _, b = string.find(c, "на сервере ")
  local text = ""
  if b == nil then 
    text = "error"
  elseif string.find(c, "час") then
    text = string.sub(c, b+1, string.find(c, " час")) .. " ч."
  else
    text = string.sub(c, b+1, string.find(c, " минут")) .. " мин."
  end
  return text
end

function lx.checkMute(nick) --Чекнуть висит ли мут
  local c = lx.com("checkban " .. nick)
  if string.find(c, "Muted: §aFalse") ~= nil then
    return false
  else
    return true
  end
end

function lx.getHostTime(timezone) --Получить текущее реальное время компьютера, хостящего сервер майна
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

return lx
