
function Creature(x,y,g,food,options)
	do -- input validation
		if (type(x) ~= "number") then error("input #1 needs to be of type number",2) end
		if (type(y) ~= "number") then error("input #2 needs to be of type number",2) end
		if (type(food) ~= "number") then error("input #3 needs to be of type number",2) end
	end
	
	local logger = false
	
	local creature =  setmetatable({
		type = "creature",
		food = food,
		pos = {x=x,y=y},
		ageT = 0
	},{
		__index = {
			getAge = function(self)
				if not (type(self) == "table" and self.type == "creature") then error("please call on creature",2) end
				return self.ageT/1000
			end,
			move = function(self,g,x,y)
				if not (type(self) == "table" and self.type == "creature") then error("please call on creature",2) end

				local oldPos = vec({self.pos.x,self.pos.y})
				local newPos = vec({self.pos.x+x,self.pos.y+y})

				local dx,dy = newPos[1]-oldPos[1], newPos[2]-oldPos[2]

				local interpolator = Mathb.GenInterpolation(oldPos,newPos)

				local wallhit = false

				for i=1, math.max(dx,dy) do
					if (dx >= dy) then
						local int = interpolator(i)
						local wall = (g.GetlightLevel(i,math.floor(int)) == 2)
						wallhit = wall
						if wall then break end
					end
				end
				

				g.fill(self.pos.x,self.pos.y,2,2,0)
				if logger then options.logger:log("clearing at x: "..self.pos.x.." and y: "..self.pos.y) end
				
				self.pos.x = newPos[1]
				self.pos.y = newPos[2]

				g.fill(self.pos.x,self.pos.y,2,2,3)
				if logger then options.logger:log("placing at x: "..self.pos.x.." and y: "..self.pos.y) end
			end,
			setPos = function(self,g,x,y)
				if not (type(self) == "table" and self.type == "creature") then error("please call on creature",2) end
				if g.getLightLevel(x,y) == 2 then
					print("bruh")
				else
					g.SetlightLevel(self.pos.x,self.pos.y,0)
					if logger then options.logger:log("clearing at x: "..self.pos.x.." and y: "..self.pos.y) end
					
					self.pos.x = x
					self.pos.y = y
					
					g.SetlightLevel(self.pos.x,self.pos.y,3)
					if logger then options.logger:log("placing at x: "..self.pos.x.." and y: "..self.pos.y) end
				end
			end
		}
	})

	g.fill(creature.pos.x,creature.pos.y,2,2,3)

	if logger then
		options.logger:log("placing at x: "..creature.pos.x.." and y: "..creature.pos.y)
	end

	return creature
end