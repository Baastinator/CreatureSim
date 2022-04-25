
function Draw()
    local PixelSize = 1 --KEEP AT 2

    local function lightLevelToCol(D, LinMode)
        if (type(D) ~= "number") then error("first input needs to be number",2) end
        return D*255
    end

    local function drawFromArray1D(x, y, T, Grid)
        if (type(x) ~= "number") then error("input #1 needs to be a number",2) end
        if (type(y) ~= "number") then error("input #2 needs to be a number",2) end
        if not (type(Grid) == "table" and Grid.type:match("grid") == "grid") then error("input #3 needs to be a table of type grid",2) end
        local P = {}
        local Pit = 0
        P.currLightLevel = nil
        for i,v in ipairs(T) do
            if lightLevelToCol(v,true) == P.currLightLevel then
            if P[Pit][2] == nil then
                P[Pit][2] = 1
            end
            P[Pit][2] = P[Pit][2] + 1

            else
                Pit = Pit + 1 
                P.currLightLevel = lightLevelToCol(v,true)
                P[Pit] = {}
                P[Pit][1] = i
                P[Pit][2] = 1
                P[Pit].col = P.currLightLevel
            end
        end
        P.currLightLevel = nil
        for i,v in ipairs(P) do
            term.drawPixels(
                (x+v[1])*PixelSize,
                y*PixelSize,
                v.col,
                PixelSize*(v[2]),
                PixelSize
            )
        end
        return P
    end

    local function drawFromArray2D(x, y, Grid) -- Draws Grid onto screen at specified location
        if (type(x) ~= "number") then error("input #1 needs to be a number",2) end
        if (type(y) ~= "number") then error("input #2 needs to be a number",2) end
        if not (type(Grid) == "table" and Grid.type:match("grid") == "grid") then error("input #3 needs to be a table of type grid",2) end
        local oT = {} 
        for i, v in ipairs(Grid.grid) do
            oT[i] = drawFromArray1D(x-1,y+i-1,v, Grid)
        end
        -- debugLog(oT,"DFA2D")
    end

    local function setPalette()
        for i=0,255 do
            term.setPaletteColor(i, colors.packRGB(i/255,i/255,i/255))
        end
    end

    local function resetPalette()
        for i=0,15 do
            local r, g, b = term.nativePaletteColor(2^i)
            term.setPaletteColor(2^i, colors.packRGB(r,g,b))
        end
    end

    return {
        lightLevelToCol = lightLevelToCol,
        PixelSize = PixelSize,
        drawFromArray1D = drawFromArray1D,
        drawFromArray2D = drawFromArray2D,
        resetPalette = resetPalette,
        setPalette = setPalette
    }
end