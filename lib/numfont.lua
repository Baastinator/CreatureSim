function PlaceNum(g,x,y,n)
	local function One(g,x,y)
		g:fill(x,y,7,7,1)
	end
	local function Two(g,x,y)
	
	end
	local function Three(g,x,y)
	
	end
	local function Four(g,x,y)
	
	end
	local function Five(g,x,y)
	
	end
	local function Six(g,x,y)
	
	end
	local function Seven(g,x,y)
	
	end
	local function Eight(g,x,y)
	
	end
	local function Nine(g,x,y)
	
	end
	local function Zero(g,x,y)
	
	end
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

