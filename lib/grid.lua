function Grid()
    local grid = {}
    local res = {}

    local function init(X, Y)
        res.x = X
        res.y = Y
        for y=1,Y do
            grid[y] = {}
            for x=1,X do
                grid[y][x] = 0
            end
        end
    end

    local function GetlightLevel(X,Y)
        return grid[Y][X].lightLevel
    end

    local function SetlightLevel(X,Y,Value)
        if (X > 0 and Y > 0 and Y < res.y and X < res.x) then
            grid[res.y-Y][X] = Value
        end
    end

    local function fill(X,Y,W,H,L)
        for y=1,H do
            for x=1,W do
                SetlightLevel(X+x-1,Y+y-1,L)
            end
        end
    end

    local function fullFill( L )
        for y=1,res.y do
            for x=1,res.x do
                SetlightLevel(x,y,L)
            end
        end
    end

    return {
        fullFill = fullFill,
        type = "grid",
        fill = fill,
        GetlightLevel = GetlightLevel,
        SetlightLevel = SetlightLevel,
        grid = grid,
        init = init
    }
end