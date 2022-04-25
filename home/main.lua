---@diagnostic disable: undefined-field
-- imports

dofile("lib/import.lua")

import("linalg")
import("List")
import("tblclean")
import("grid")
import("draw")
import("GUI")

-- globals

local Grid = Grid()
local draw = Draw()
local gui

local res = {}
local tres = {}

local debugMode = false
local gameLoop = true
local framesElapsed = 0

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
            gameLoop = false
        end
        key = nil
    end
end

local function setVertices()
end

-- main functions

local function Init()
    tres.x, tres.y = term.getSize(1)
    res.x = math.floor(tres.x / draw.PixelSize)
    res.y = math.floor(tres.y / draw.PixelSize)
    Grid.init(res.x,res.y-ui.height)
    gui = GUI(50,res)
    term.clear()
    term.setGraphicsMode(2)
    draw.setPalette()
    term.drawPixels(0,0,0,tres.x,tres.y)
end

local function Start()
    setVertices()
end

local function PreUpdate() 
    Grid.init(res.x,res.y-ui.height)
end

local function Update()
end
 
local function Render()
    draw.drawFromArray2D(0,0,Grid)
    draw.drawFromArray2D(0,res.y-ui.height+1,gui)
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
        PreUpdate()
        Update()
        Render()
        os.queueEvent("")
        os.pullEvent("")
        framesElapsed = framesElapsed + 1;
    end
    Closing()
end

-- execution

local ok, err = pcall(parallel.waitForAny,main,userInput)
if not ok then Closing() end
printError(err)