local lx - require("lx")
local serialization = require("serialization")
local fs = require("filesystem")
local term = require("term")
local component = require("component")
local gpu = component.gpu
local unicode = require("unicode")
local event = require("event")

event.shouldInterrupt = function () -- Пидорасам которые хотят закрыть прогу пизда
  return false 
end 

local WIDTH, HEIGHT = 146, 42 --Разрешение моника 146/112 x 42

local PATH = "/usr/sostav"

local players = {
  
}

buttons = {}


function drawButton(name,x,y, w, h, bg, fg, text, onBClick)
  buttons.name = {}
  buttons.name[1] = x
  buttons.name[2] = y
  buttons.name[3] = w
  buttons.name[4] = h
  buttons.name[5] = onBClick
  buttons.name[6] = true -- Enabled
  -------
  oldbg = gpu.getBackground()
  oldfg = gpu.getForeground()
  gpu.setBackground(bg)
  gpu.setForeground(fg)
  -------
  gpu.fill(x, y, w, h, " ")
  lx.text(x,math.max(y,h)/2 - math.min(y, h)/2, text)
  gpu.setBackground(oldbg)
  gpu.setForeground(oldfg)
end

local function onClick(_,_, x, y, idTouch, playerName) -- Обработка нажатия всех кнопакав
  gpu.set(9,40, "ПХД ПРОМАЗАЛ: "..playerName.."           ")
  for _, name in pairs(buttons) do
    gpu.set(20,20,"Нажатие по экрану: "..x.." "..name[1].." "..name[3].." ".. y.." "..name[2].." ".. name[4].."       ")
    if x >= name[1] and x <= name[3]+name[1] and y >= name[2] and y <= name[4]+name[2] and name[6] == true then
      name[5](playerName)
      break
    end
  end
end

local function addTouch(playerName)
  
  -- Ввод ника
  lx.text((math.modf(WIDTH/2)-25), HEIGHT-6,"&bВведите ник:")
  term.setCursor(mid-30, HEIGHT-6)
  local nick = io.read()
  gpu.set((math.modf(WIDTH/2)-25), HEIGHT-6,"                                                                                        ")
  -- Конец ввода ёпты
  -- Код с ником ...
  
end

file = io.open(PATH.."/BD", "r")
local reads = file:read(9999999)
if reads ~= nil then
	admins = serial.unserialize(reads)
else
	admins = {}
end
file:close()





event.listen("touch", onClick)


local w, h = gpu.getResolution()


term.clear()
gpu.setResolution(WIDTH, HEIGHT)
lx.box()

drawButton("AddButtonObject", 100, 37, 3, 6, 0x000000, 0x00FF00, "+", addTouch)
while true do
  event.pull()
end
