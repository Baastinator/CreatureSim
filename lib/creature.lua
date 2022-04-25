function Creature(food)
	do -- input validation
		if (type(food) ~= "number") then error("input #1 needs to be a number",2) end
	end
	return setmetatable({
		type = "creature",
		food = food,
		ageT = 0
	},{
		__index = {
			getAge = function(a)
				if not (type(a) == "table" and a.type == "creature") then error("please execute getAge on creature",2) end
				return a.ageT/1000
			end
		}
	})
end