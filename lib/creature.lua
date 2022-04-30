function Creature(x,y,g,food)
	do -- input validation
		if (type(x) ~= "number") then error("input #1 needs to be of type number",2) end
		if (type(y) ~= "number") then error("input #2 needs to be of type number",2) end
		if (type(food) ~= "number") then error("input #3 needs to be of type number",2) end
	end
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
				g.SetlightLevel(self.pos.x,self.pos.y,0)
				print("clearing at x: "..self.pos.x.." and y: "..self.pos.y)
				self.pos.x = self.pos.x + x
				self.pos.y = self.pos.y + y
				g.SetlightLevel(self.pos.x,self.pos.y,3)
				print("placing at x: "..self.pos.x.." and y: "..self.pos.y)
			end,
			setPos = function(self,g,x,y)
				if not (type(self) == "table" and self.type == "creature") then error("please call on creature",2) end
				g.SetlightLevel(self.pos.x,self.pos.y,0)
				self.pos.x = x
				self.pos.y = y
				g.SetlightLevel(self.pos.x,self.pos.y,3)
			end
		}
	})

	g.SetlightLevel(creature.pos.x,creature.pos.y,3)
	print("placing at x: "..creature.pos.x.." and y: "..creature.pos.y)

	return creature
end