function Creature(x,y,g,food)
	do -- input validation
		if (type(x) ~= "number") then error("input #1 needs to be a number",2) end
		if (type(y) ~= "number") then error("input #2 needs to be a number",2) end
		if (type(food) ~= "number") then error("input #3 needs to be a number",2) end
	end
	local creature =  setmetatable({
		type = "creature",
		food = food,
		pos = {x=x,y=y},
		ageT = 0
	},{
		__index = {
			getAge = function(a)
				if not (type(a) == "table" and a.type == "creature") then error("please execute getAge on creature",2) end
				return a.ageT/1000
			end,
			move = function(a,g,x,y)
				g.SetlightLevel(a.pos.x,a.pos.y,0)
				a.pos.x = a.pos.x + x
				a.pos.y = a.pos.y + y
				g.SetlightLevel(a.pos.x,a.pos.y,3)
			end,
			setPos = function(a,g,x,y)

			end
		}
	})

	g.SetlightLevel(creature.pos.x,creature.pos.y,3)

	return creature
end