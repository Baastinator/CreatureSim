---@diagnostic disable: undefined-field
-- imports

require(".lib.import")

import("mathb")
import("linalg")
import("List")
import("logger")
import("tblclean")
import("grid")
import("draw")
import("GUI")

-- globals

local logger = Logger()
local Grid = Grid()
local draw = Draw()
local gui

import("creature")
local res = {}
local tres = {}

local debugMode = true
local gameLoop = true
local paused = false
local UPS = 165
local framesElapsed = 0
local creatures = List("creature")

local fpsTime, updateTime

local ui = {
    height = 50
}

-- side functions

local function userInput()
    local key, event, is_held
    while true do
---@diagnostic disable-next-line: undefined-field
        event, key, is_held = os.pullEvent("key")
        
        if key == keys.space then
            paused = not paused
            -- if paused then gui:pause() end
        elseif key == keys.right then
            gameLoop = false
        end
        
        key = nil
    end
end

local function setVertices()
    creatures:add(Creature(30,50,Grid,0,{logger=logger}))
end

-- main functions

local function Init()
    tres.x, tres.y = term.getSize(1)
    res.x = math.floor(tres.x / draw.PixelSize)
    res.y = math.floor(tres.y / draw.PixelSize)
    Grid.init(res.x,res.y-ui.height)
    gui = GUI(ui.height,res)
    term.clear()
    term.setCursorPos(1,1)
    term.setGraphicsMode(2)
    draw.setPalette()
    term.drawPixels(0,0,0,tres.x,tres.y)
end

local function Start()
    setVertices()
    fpsTime = ccemux.milliTime()
    updateTime = fpsTime 
end

local function PreUpdate() 
end


local function Update()
    local dt = (ccemux.milliTime()-updateTime)/1000
    if (dt > 1/UPS) then
        creatures:get(1):move(Grid,1,math.sin(framesElapsed*math.pi/360))
        updateTime = ccemux.milliTime()
    end 
end

local function Render()
    local fps = math.floor(1000000000/(ccemux.nanoTime()-fpsTime))
    if (fps ~= math.huge) then
        gui:displayNum(fps)
    end
    fpsTime = ccemux.nanoTime()
    draw.drawFromArray2D(0,0,Grid)
    draw.drawFromArray2D(0,res.y-ui.height+1,gui)

    framesElapsed = framesElapsed + 1;
    logger:tick()
end

local function Closing()
    term.clear()
    term.setGraphicsMode(0)
    draw.resetPalette()
    if not debugMode then
        term.clear()
        term.setCursorPos(1,1)
    end
end

-- main structure

local function main()
    Init()
    Start()
    while gameLoop do
        if not paused then
        PreUpdate()
        Update()
        Render()
        end
        os.queueEvent("")
        os.pullEvent("")
    end
    Closing()
end

-- execution

local ok, err = pcall(parallel.waitForAny,main,userInput)
if not ok then Closing() end
if err ~= 1 then printError(err) end