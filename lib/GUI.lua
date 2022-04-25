import("numfont")

function GUI(height,res)
	do
		if (type(height) ~= "number") then error("input #1 needs to be a number",2) end
		if not (type(res.x) == "number" and type(res.y) == "number") then error("input #2 needs to be an xy vector",2) end
	end
	
	local gui = Grid()
	gui.type = "grid.gui"

	local pause = function(g)
		for i=0,7 do
			g.fill(height/2-6+2*i,height/2-7+i,2,16-2*i,1)
		end
	end

	local unpause = function(g)
		g.fill(height/2-6,height/2-7,16,16,0)
		g.fill(height/2-6,height/2-7,5,16,1)
		g.fill(height/2+5,height/2-7,5,16,1)
	end	

	gui.init(res.x,height)
	gui.fill(1,1,res.x,height,1)
	gui.fill(2,2,res.x-3,height-3,0)
	pause(gui)

	for i=0,9 do
		PlaceNum(gui,height/2+20+18*i,height/2-6,i)
	end

	return setmetatable(gui,{
		__index = {
			pause=pause,
			unpause=unpause
		}	
	})
end