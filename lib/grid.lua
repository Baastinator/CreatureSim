function Grid()
    local grid = {}
    local res = {}
    local Type = "grid"

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
        if (X > 0 and Y > 0 and Y < res.y and X < res.x) then
            X = math.floor(X)
            Y = math.floor(Y)
            return grid[Y][X]
        end
    end

    local function SetlightLevel(X,Y,Value)
        if (X > 0 and Y > 0 and Y < res.y and X < res.x) then
            X = math.floor(X)
            Y = math.floor(Y)
            grid[Y][X] = Value
        end
    end

    local function fill(X,Y,W,H,L)
        do --input validation
            if (type(X) ~= "number") then error("input #1 needs to be a number",2) end
            if (type(Y) ~= "number") then error("input #2 needs to be a number",2) end
            if (type(W) ~= "number") then error("input #3 needs to be a number",2) end
            if (type(H) ~= "number") then error("input #4 needs to be a number",2) end
            if (type(L) ~= "number") then error("input #5 needs to be a number",2) end
        end
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
        fill = fill,
        res = res,
        Type = Type,
        GetlightLevel = GetlightLevel,
        SetlightLevel = SetlightLevel,
        grid = grid,
        init = init
    }
end