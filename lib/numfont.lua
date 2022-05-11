function PlaceNum(g,x,y,n)
	do --input validation
		if not (type(g) == "table" and g.Type == "grid.gui") then error("input #1 needs to be a table of type grid.gui",2) end
		if (type(x) ~= "number") then error("input #2 needs to be a number",2) end
		if (type(y) ~= "number") then error("input #3 needs to be a number",2) end
		if (type(n) ~= "number") then debugLog(type(n),"Placenum.4.notNum") error("input #4 needs to be a number",2) end
		if (n > 9 or n < 0) then error("input #4 needs to be non-negative integer below 10",2) end
	end
	local function One(g,x,y)
		g.fill(x+2,y+12,12,2,1)
		g.fill(x+6,y+0,4,12,1)
		g.fill(x+4,y+2,2,2,1)
	end
	local function Two(g,x,y)
		g.fill(x,y+12,14,2,1)
		g.fill(x,y+10,6,2,1)
		g.fill(x+2,y+8,8,2,1)
		g.fill(x+4,y+6,8,2,1)
		g.fill(x+8,y+4,6,2,1)
		g.fill(x+10,y+2,4,2,1)
		g.fill(x+0,y+2,4,2,1)
		g.fill(x+2,y,10,2,1)
	end
	local function Three(g,x,y)
		g.fill(x+2,y+12,10,2,1)
		g.fill(x+10,y+8,4,4,1)
		g.fill(x+0,y+10,4,2,1)
		g.fill(x+4,y+6,8,2,1)
		g.fill(x+6,y+4,4,2,1)
		g.fill(x+8,y+2,4,2,1)
		g.fill(x+2,y+0,12,2,1)
	end
	local function Four(g,x,y)
		g.fill(x+8,y+0,4,14,1)
		g.fill(x+0,y+8,14,2,1)
		g.fill(x+0,y+6,4,2,1)
		g.fill(x+2,y+4,4,2,1)
		g.fill(x+4,y+2,4,2,1)
		g.fill(x+6,y+0,2,2,1)
	end
	local function Five(g,x,y)
		g.fill(x+2,y+12,10,2,1)
		g.fill(x+0,y+10,4,2,1)
		g.fill(x+10,y+6,4,6,1)
		g.fill(x+0,y+4,12,2,1)
		g.fill(x+0,y+0,4,4,1)
		g.fill(x+4,y+0,8,2,1)
	end
	local function Six(g,x,y)
		g.fill(x+2,y+12,10,2,1)
		g.fill(x+0,y+4,4,8,1)
		g.fill(x+10,y+8,4,4,1)
		g.fill(x+4,y+6,8,2,1)
		g.fill(x+2,y+2,4,2,1)
		g.fill(x+4,y+0,8,2,1)
	end
	local function Seven(g,x,y)
		g.fill(x+4,y+8,4,6,1)
		g.fill(x+6,y+6,4,2,1)
		g.fill(x+8,y+4,4,2,1)
		g.fill(x+0,y+0,14,2,1)
		g.fill(x+0,y+2,4,2,1)
		g.fill(x+10,y+2,4,2,1)
	end
	local function Eight(g,x,y)
		g.fill(x+2,y+12,10,2,1)
		g.fill(x+0,y+8,2,4,1)
		g.fill(x+10,y+8,4,4,1)
		g.fill(x+6,y+8,4,2,1)
		g.fill(x+2,y+6,8,2,1)
		g.fill(x+0,y+4,6,2,1)
		g.fill(x+0,y+2,4,2,1)
		g.fill(x+2,y+0,8,2,1)
		g.fill(x+10,y+2,2,4,1)
	end
	local function Nine(g,x,y)
		g.fill(x+2,y+12,8,2,1)
		g.fill(x+8,y+10,4,2,1)
		g.fill(x+10,y+8,4,2,1)
		g.fill(x+2,y+6,12,2,1)
		g.fill(x+0,y+2,4,4,1)
		g.fill(x+10,y+2,4,4,1)
		g.fill(x+2,y+0,10,2,1)
	end
	local function Zero(g,x,y)
		g.fill(x,y+4,4,6,1)
		g.fill(x+2,y+2,2,2,1)
		g.fill(x+4,y+0,6,2,1)
		g.fill(x+8,y+2,4,2,1)
		g.fill(x+10,y+4,4,6,1)
		g.fill(x+10,y+10,2,2,1)
		g.fill(x+2,y+10,4,2,1)
		g.fill(x+4,y+12,6,2,1)
	end
	g.fill(x,y,14,14,0)
	if(n == 1) then
		One(g,x,y)
	elseif(n==2) then
		Two(g,x,y)
	elseif(n==3) then
		Three(g,x,y)
	elseif(n==4) then
		Four(g,x,y)
	elseif(n==5) then
		Five(g,x,y)
	elseif(n==6) then
		Six(g,x,y)
	elseif(n==7) then
		Seven(g,x,y)
	elseif(n==8) then
		Eight(g,x,y)
	elseif(n==9) then
		Nine(g,x,y)
	elseif(n==0) then
		Zero(g,x,y)
	end
end

function PlaceNums(g,x,y,n)
	do --input validation
		if not (type(g) == "table" and g.Type == "grid.gui") then error("input #1 needs to be a table of type grid.gui",2) end
		if (type(x) ~= "number") then error("input #2 needs to be a number",2) end
		if (type(y) ~= "number") then error("input #3 needs to be a number",2) end
		if not (type(n) == "number" or type(n) == "string") then error("input #4 needs to be a number or a string",2) end
	end
	local nBStr = n..""
	local nChaT = {}
	local nStr = nBStr:gsub(".",function (a) table.insert(nChaT,a) end)
	for i, v in ipairs(nChaT) do
		PlaceNum(g,x+18*i-#nChaT*18,y,tonumber(v))
	end
end