Mathb = {
    factorial = function( a ) 
        if not (type(a) == "number") then error("input needs to be non-negative integer",2) end
        if (math.floor(a) ~= a or a < 0) then error("factorial: bad input",2) end
        if (a == 0) then return 1 end
        local output = 1
        for i=1,a do
            output = output * i
        end
        return output
    end,
    round = function(number, digits)
        if not type(number) == "number" then error("input needs to be number",2) end
        if not (type(digits) == "number") or not (digits == math.floor(digits)) then error("input must be an integer",2) end
        digits = digits or 0
        number = number * (10^digits)
        number = number + 0.5
        number = math.floor(number)
        number = number / (10^digits)
        return number
    end,        
    GenInterpolation = function(P1, P2)
        if not (type(P1) == "table" and P1.Type == "mat.vec") then error("input 1 needs to be a vector") end
        if not (type(P2) == "table" and P2.Type == "mat.vec") then error("input 2 needs to be a vector") end

        local dx = (P2[1]-P1[1])
        local dy = (P2[2]-P1[2])
        local base = (function() if dx >= dy then return "x" end return "y" end)()
        local m = (function() if base == "x" then return dy/dx end return dx/dy end)()

        local interpolation = function(pos)
            if base == "x" then
                return (P1[2] + m * (pos - P1[1]))
            else
                return (P1[1] + m * (pos - P1[2]))
            end
        end
        return interpolation
    end,
    Interpolate = function(P1, P2, pos)
        local m = (P2[2]-P1[2]) / (P2[1]-P1[1])
        return (P1[2] + m * (pos - P1[1]))
    end
}
