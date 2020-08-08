local Rock = {}



function Rock:New(obj)
  local obj = obj or {}	
  setmetatable(obj,self)
  self.__index = self	  	 	 
  return obj	
end

function Rock:Goals(obj)
  return { 
    Goal1 = {Size = obj.Size*2};		
	Goal2 = {Size = obj.Size/3; Transparency = 1}	
  }
end

function Rock:RunTweens(Tween1,Tween2,Cor)
  Tween1:Play()
   Cor:Wrap(function()
     wait(2)	
	 Tween2:Play()
   end)		  
end

function Rock:MakeInstance()
  local rock = Instance.new('Part')		
  rock.Parent = workspace		
  rock.Anchored = true		
  rock.CanCollide = false			
  return rock	
end

function Rock:Material(hum,obj)
  local MaterialColor = hum.FloorMaterial		
  obj.Material = MaterialColor
  obj.Color = workspace.Terrain:GetMaterialColor(MaterialColor)		
end

function Rock:SetUpPosition(obj,rng,rp,amp,i)
  obj.Size = rng:Return(math.random(1,2),obj) 		
  local RngC = rng:Return(math.random(1,2)	,1,-20,30)
  obj.CFrame = rp.CFrame * CFrame.fromEulerAnglesXYZ(math.rad(0),math.rad(i),math.rad(RngC))
  obj.CFrame = obj.CFrame * CFrame.new(0,-3,-4*(amp*2))	
end

function Rock:Front(obj,rp,i,rng)
  local RngC = rng:Return(math.random(1,2)	,1,-20,30)		   	
  obj.CFrame = rp.CFrame * CFrame.new(0,-4,-(i * 1.5)) * CFrame.fromEulerAnglesXYZ(math.rad(0),math.rad(math.random(10,90)),math.rad(RngC))	    	
  obj.Size *= i/3/2	   
end

return Rock