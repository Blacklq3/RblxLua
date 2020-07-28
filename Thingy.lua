function Main.Require()
	local Requires,Calling = {},{}
    local I,I2 = 0,0
	for i,v in pairs(script:GetDescendants()) do 
	  if not v:IsA("ModuleScript") then return end	
		Requires[I] = require(v)
		Calling[I2] = Requires[I].CommandFunction()
		I+= 1
		I2+= 1
	end	   	
end