function Walk.GetPlayer(Player,CallerName)
	  local PlayerNeeded = {}
	  setmetatable(PlayerNeeded,Walk)
       for i,v in pairs(game:GetService("Players"):GetChildren()) do 
         if string.sub(string.lower(v.Name),1,#Player) == string.lower(Player) then
           if string.lower(v.Name) == string.lower(CallerName) then -- do nothing
            else        
              table.insert(PlayerNeeded,v)    
           end
         end    
       end
      return PlayerNeeded
    end

    function Walk:All(Player)
	   local PlayersNeeded = {}
	     if self[1] == string.lower(Player) and self[2] == nil then else  
	       if string.lower(Player) == "all" then
		     for i,v in pairs(game:GetService("Players"):GetChildren()) do 
			    table.insert(PlayersNeeded,v)	   	
		     end		
		   end
	     end	
	   return PlayersNeeded
    end