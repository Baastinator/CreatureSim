---@diagnostic disable: undefined-field
-- imports

package.path = "/?.lua;/lib/?.lua"

require("mathb")
require("linalg")
require("List")
require("tblclean")
require("grid")
require("draw")

-- globals

local Grid = Grid()
local draw = Draw()
local gui

local res = {}
local tres = {}

local debugMode = true
local gameLoop = true
local paused = false
local UPS = 165
local framesElapsed = 0

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
            gameLoop = false
        end
        
        key = nil
    end
end

-- main functions

local function Init()
    tres.x, tres.y = term.getSize(1)
    res.x = math.floor(tres.x / draw.PixelSize)
    res.y = math.floor(tres.y / draw.PixelSize)
    Grid.init(res.x,res.y)
    term.clear()
    term.setCursorPos(1,1)
    term.setGraphicsMode(2)
    draw.setPalette()
    term.drawPixels(0,0,0,tres.x,tres.y)
end

local f = function(x,y) 
    x,y = math.floor(x-res.x/2), math.floor(res.y/2-y)

    local angle = math.rad(-0)
    return 
    -- -y^2/1000-(x^3/100000-x)
    -- y^2+x^2-10^2
    -- y-(200/(1+math.exp(-x/50))-100)
    -- (
    --     ((x*math.cos(angle)+y*math.sin(angle))/res.x)^2 + 
    --     ((x*math.sin(angle)-y*math.cos(angle))/res.y)^2 - 
    --     0.49^2
    -- )
    x^2 - y^2 + y^4/60000- 100^2
end

local function Start()
    fpsTime = ccemux.milliTime()
    updateTime = fpsTime

    local sign = function(x) if x >= 0 then return 1 else return -1 end end
    local baseGrid = {}

    for y=1,res.y+1 do
        baseGrid[y] = {}
        for x=1,res.x+1 do
            baseGrid[y][x] = sign(f(x,y))
        end
    end

    for y=1,res.y do
        for x=1,res.x do
            local sum = (
                baseGrid[y][x] +
                baseGrid[y][x+1] + 
                baseGrid[y+1][x] + 
                baseGrid[y+1][x+1]
            )
            if not (sum == -4 or sum == 4) then
                Grid.SetlightLevel(x, y, 1)
            end
        end
    end

    for i=1,res.x do
        if (Grid.GetlightLevel(i,res.y/2) < 0.3) then
            Grid.SetlightLevel(i,res.y/2,0.3)
        end
    end
    for i=1,res.y do
        if (Grid.GetlightLevel(res.x/2,i) < 0.3) then
            Grid.SetlightLevel(res.x/2,i,0.3)
        end
    end
end

local function PreUpdate() 
end


local function Update()
end

local function Render()
    draw.drawFromArray2D(0,0,Grid)
    framesElapsed = framesElapsed + 1;
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
    end
    Closing()
end

-- execution

local ok, err = pcall(parallel.waitForAny,main,userInput)
if not ok then Closing() end
if err ~= 1 then printError(err) end