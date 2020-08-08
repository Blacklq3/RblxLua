local random = {}

function random:New(obj)
  obj = obj or {}	  
  setmetatable(obj,self)	  
  self.__index = self	
  return obj
end

function random:Return(R1,R2,R3,R4)
  if R1 == R2 then 
    return R3		  
  elseif R1 ~= R2 and (typeof(R2)) == "number" then 
    return R4		
  elseif (typeof(R2)) ~= "number" and R1 == 1 then 
    return R2.Size/2  	   	
  elseif (typeof(R2)) ~= "number" and R1 ~= 1 then
	return R2.Size/2.5	
  end 
end

function random:GiveHalf()
  return math.ceil(math.random() * 2)	
end


return random