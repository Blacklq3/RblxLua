--[[                                                          SERVER                                                     ]]-- 
local module = assert(require(game:GetService("ReplicatedStorage").Modules.Skills.FireKick))
local debris = game:GetService("Debris")

--[[ Fire Stomp]]
-- SETTINGS -- 
local SoundIdStomp = "rbxassetid://1544022435" -- Your sound id
local VolumeStomp = 1.1 -- how loud sound will be
local AreaVolume3dStomp = 5 -- from how far away players can hear the sound
local AnimationIdStomp = "rbxassetid://5266468618" -- your animation id Note: you don't need to set priority it will be done in script
local damageStomp = 25 -- how much damage your move will do 
-- SETTINGS --
module.FireStompServer(VolumeStomp,AreaVolume3dStomp,damageStomp,SoundIdStomp,AnimationIdStomp)
--[[fire kick]]--









--[[                                                   MODULE                                                                   ]]--











FireStompLocal = function(player)
    local UIS = game:GetService("UserInputService")
    wait()
    local cooldown = 5
    local remote = game:GetService("ReplicatedStorage").Remotes.Skills.FireStomp
    local character = player.Character
    local hum = character:WaitForChild("Humanoid")
    local debounce = true
    local UIS = game:GetService("UserInputService")
    local debris = game:GetService("Debris")
    
    

     local ShouldStop = function(hum)
       local saved = {}
       saved[1] = hum.WalkSpeed
       saved[2] = hum.JumpPower
        
        spawn(function()
          for i = 1,11 do
           wait(0.1) 
           hum.AutoRotate = false
           hum.WalkSpeed = 0
           hum.JumpPower = 0	
           i+=1      
          end    
        end)	
        
        spawn(function()
         wait(1.7)  
         hum.AutoRotate = true  
         hum.WalkSpeed = saved[1]
         hum.JumpPower = saved[2]   
        end)	  
     end    
       
    
    
    local keypressed = true
       
 UIS.InputBegan:Connect(function(input,IsTyping)
  if IsTyping then return end
   if hum:GetState() == Enum.HumanoidStateType.Jumping then return end
    if hum:GetState() == Enum.HumanoidStateType.Freefall then return end	
     if keypressed ~= true then return end
      if input.KeyCode == Enum.KeyCode.C and debounce then
        local bool = workspace:FindFirstChild("DashedBool")
        if bool == true then return end
        keypressed = false
        debounce = false
        ShouldStop(hum)
        wait(0.1)
        remote:InvokeServer(player)	
        wait(cooldown)	
        debounce = true	
        keypressed = true		
       end
   end)		
end;	


FireStompServer = function(Volume,VolumeFX,Damage,SOUNDID,AnimationId)
 local remote = game:GetService("ReplicatedStorage").Remotes.Skills.FireStomp
 local debris = game:GetService("Debris")
 local repstorage = game:GetService("ReplicatedStorage")
 local TweenService = game:GetService("TweenService")	
 local Auras = repstorage.ScriptAssets.FireStomp.Auras:GetChildren()	
 local Speed = 32.5
 local Force = 11000	
    
    local NoSh = function(obj)
    obj.Anchored = true
    obj.CanCollide = false	
    end
    
    
   local Audio = function(rootpart)
    spawn(function()
     wait(0.55)
     local part = Instance.new('Part',rootpart)	
     part.Position = rootpart.Position
     part.Transparency = 1
     NoSh(part)
     local sound = Instance.new('Sound')
     sound.SoundId = SOUNDID	
     sound.Parent = part
     sound.Looped = false
     sound.Volume = Volume
     sound.EmitterSize = VolumeFX 
     sound:Play()
    end)
   end  	  
     
    
 local knockback = function(rootpart,speed,totalforce,player,hum1)
    if hum1:GetState() == Enum.HumanoidStateType.Jumping then return end	
    if hum1:GetState() == Enum.HumanoidStateType.Freefall then return end
    local bodyvelocity1 = Instance.new('BodyVelocity',rootpart)
    bodyvelocity1.MaxForce = Vector3.new(totalforce,totalforce,totalforce)
    local LCframe = player.Character.HumanoidRootPart.CFrame * CFrame.fromEulerAnglesXYZ(math.rad(0),math.rad(180),math.rad(0))
    bodyvelocity1.Velocity = LCframe.lookVector * 50
    debris:AddItem(bodyvelocity1,1)
 end	
           
    
  local damage = function(rootpart,player)	
     local Hitbox = workspace.ScriptAssets.hitbox:Clone()
     Hitbox.CFrame = rootpart.CFrame * CFrame.new(0,0,-12)
     Hitbox.Parent = workspace
     local Debounce = true
     Hitbox.Touched:Connect(function(h)
         if h.Parent:FindFirstChild('Humanoid')and h.Parent.Name ~= player.Name and Debounce then	
            Debounce = false
            local Enemy = h.Parent.Humanoid
            Enemy:TakeDamage(Damage)
            local player1 = game.Players:GetPlayerFromCharacter(h.Parent)
            local character1 = player1.Character
            local hum1 = character1:WaitForChild("Humanoid")	 
            local rootpart1 = character1:WaitForChild("HumanoidRootPart")	
            local knockbackAnim = Instance.new('Animation',workspace)	
            debris:AddItem(knockbackAnim, 5)
            knockbackAnim.AnimationId = "rbxassetid://5206152851"
            local track = hum1:LoadAnimation(knockbackAnim)	
            track.Priority = Enum.AnimationPriority.Action	
            track:Play()	
            knockback(rootpart1,Speed,Force,player1,hum1)		
         end
      end)
     debris:AddItem(Hitbox, 2)
  end
    
    
   local animation = function(hum,char)
      spawn(function()
        for i,v in pairs(Auras) do
            local b = v:Clone()
            b.Parent = char.RightLowerArm
            debris:AddItem(b, 1.5)
        end	
      end)
    local Animation = Instance.new('Animation',workspace)
    Animation.AnimationId = AnimationId	
    local track = hum:LoadAnimation(Animation)	
    track.Priority = Enum.AnimationPriority.Action
    track:Play() 
    wait(0.75)
   end

    
    


    
    
    local Effects = function(rootpart)
      local Under = assert(require(script.SubMod.UnderModule))
      local ring = repstorage.ScriptAssets.FireStomp.Ring2	
      local tweeninfo1 = TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
      local goals1 = {Size = ring.Size*1.5; Transparency = 1;}	 
      local FirePartParent = repstorage.ScriptAssets.FireStomp
          local Fires = {
          F1 = FirePartParent.Part1:Clone();	
          F2 = FirePartParent.Part2:Clone();	 	  
          F3 = FirePartParent.Part3:Clone();		
          F4 = FirePartParent.Part4:Clone();		
          F5 = FirePartParent.Part5:Clone();		
          F6 = FirePartParent.Part6:Clone();		
          F7 = FirePartParent.Part7:Clone();		
          F8 = FirePartParent.Part8:Clone();		
          F9 = FirePartParent.Part9:Clone();		
          }
        Under.SortFire(Fires.F1,Fires.F2,Fires.F3,Fires.F4,Fires.F5,Fires.F6,Fires.F7,Fires.F8,Fires.F9,rootpart)
          
        local tweenring = TweenService:Create(ring,tweeninfo1,goals1)
        tweenring:Play()

        
    end	
      
    remote.OnServerInvoke = function(player)
     local IsAnySkillFiring = repstorage.ScriptAssets.Skills.IsFiring
      if IsAnySkillFiring.Value ~= true then
        IsAnySkillFiring.Value = true 
        local character = player.Character
        local hum = character:WaitForChild("Humanoid")
        local rootpart = character:WaitForChild("HumanoidRootPart")
        print("Runned")
        Audio(rootpart)
        animation(hum,character)
        damage(rootpart,player)
        Effects(rootpart)
        IsAnySkillFiring.Value = false	
        end	
    end
    
end;











--[[                                                         SUB MODULE                                       ]]--


local module = {
	SortFire = function(Part1,Part2,Part3,Part4,Part5,Part6,Part7,Part8,Part9,rootpart)
		local debris=  game:GetService("Debris")
		local TweenService = game:GetService("TweenService")
		local fire = workspace.ScriptAssets.FirePart.Fire
		local rock = workspace.ScriptAssets.Rock
		local repstorage = game:GetService("ReplicatedStorage")
		local RingToCopy = repstorage.ScriptAssets.FireStomp.Ring2
 		local EffectsRange = -8
		
		local Rng1 = function(randomizer1)
			if randomizer1 == 1 then
			 return -20
			else
			 return 30		
			end
		end
		
		local ToSize = function(randomsize,rock2)
			if randomsize == 1 then
			 return rock2.size/2
			else
			 return rock2.size/2.5
			end
			
		end
		
		local tweenrock = function(rock2)
		  local tweeninfo = TweenInfo.new(0.7,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out)
		  local goals = {
		  Size = rock2.Size*2
		  }
		  local goals2 = {
		  Size = rock2.Size/3;		 
		  Transparency = 1		
		  }			
		  local newtween = TweenService:Create(rock2,tweeninfo,goals)
		  local newtween2 = TweenService:Create(rock2,tweeninfo,goals2)
		  newtween:Play()
			spawn(function()
			 wait(2)	
			 newtween2:Play()	
			end)
		end
		
		local function makerings()
		  local tweeninfo2 = TweenInfo.new(1.2,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)	
		  local Ring = RingToCopy:Clone()	
		  local Ring2 = RingToCopy:Clone()	
	      local Ring3 = RingToCopy:Clone()
		  Ring2.Size = Ring.Size/1.25
		  Ring3.Size = Ring2.Size/1.5	
		  local goals3 = {
		  Size = Ring.Size*2;	
		  Transparency = 1	
		  }		
		  local goals4 = {
		  Size = Ring2.Size*2;	
		  Transparency = 1	
		  }			  
		  local goals5 = {
		  Size = Ring3.Size*2;	
		  Transparency = 1	
		  }			
			
			
		 local newtween3 = TweenService:Create(Ring,tweeninfo2,goals3)
		 local newtween4 = TweenService:Create(Ring2,tweeninfo2,goals4)
		 local newtween5 = TweenService:Create(Ring3,tweeninfo2,goals5)
		 Ring.Parent = workspace
		 Ring.CFrame = rootpart.CFrame * CFrame.new(0,-3,0)		
		 Ring2.Parent = workspace
		 Ring2.CFrame = rootpart.CFrame * CFrame.new(0,-3,0)			
		 Ring3.Parent = workspace
	     Ring3.CFrame = rootpart.CFrame * CFrame.new(0,-3,0)				
		 newtween3:Play()
	     newtween4:Play()		         
		 newtween5:Play()	     
		 debris:AddItem(Ring, 3)
		 debris:AddItem(Ring2, 3)
		 debris:AddItem(Ring3, 3)	
		 spawn(function()
		  while wait() do 
			 RingToCopy.Size = Vector3.new(19.1, 0.225, 16.55)
			 RingToCopy.Transparency = 0.5
			 end
		  end)
		end
		
		
		
		
		
	  local DrawRocks = function()
		for i = 1,360 do
				local NewRandomizer = function()
				  local Random1 = math.random(1,2)
				  local Random2 = Random1
				  return Random2
				end
			local Random1 = Rng1(NewRandomizer())	
			local randomsize = math.random(1,2)
			local rock2 = rock:Clone()
			rock2.Material = workspace.baseplate.Material
			rock2.Color = workspace.baseplate.Color
			rock2.Size = ToSize(randomsize,rock2)
			rock2.Parent = workspace 
			rock2.CFrame = rootpart.CFrame * CFrame.fromEulerAnglesXYZ(math.rad(0),math.rad(i),math.rad(Random1)) * CFrame.new(0,-3,-4)
			tweenrock(rock2)
			i+= 10
			debris:AddItem(rock2, 3)
		end
	 end
		
	   local Fix = function(v)
		v.CanCollide = false
		v.Anchored = true
		debris:AddItem(v, 5)
		v.Parent = workspace
	   end
		
		local disappear = function(v)
		 spawn(function()
		   local tweeninf = TweenInfo.new(1,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out) 	
		   local gols = {Size = fire.Size; Heat = fire.Heat;}	
		   local TrackTween = TweenService:Create(v.Fire,tweeninf,gols)	
		   TrackTween:Play()	
		   wait(2)
		   v:Destroy()
		 end)   	
		end	
		
		makerings()
		DrawRocks()
		
		
		
		Fix(Part1)
		Part1.CFrame = rootpart.CFrame * CFrame.new(0,0,EffectsRange) * CFrame.fromEulerAnglesXYZ(math.rad(0),math.rad(-30),math.rad(0))
		Fix(Part2)
		Part2.CFrame = rootpart.CFrame * CFrame.new(0,0,EffectsRange) * CFrame.fromEulerAnglesXYZ(math.rad(0),math.rad(0),math.rad(0))
		Fix(Part3)
		Part3.CFrame = rootpart.CFrame * CFrame.new(0,0,EffectsRange) * CFrame.fromEulerAnglesXYZ(math.rad(0),math.rad(30),math.rad(0))
		Fix(Part4)
		Part4.CFrame = Part1.CFrame * CFrame.new(0,0,-7)
		Fix(Part5)
		Part5.CFrame = Part2.CFrame * CFrame.new(0,0,-7)
		Fix(Part6)
		Part6.CFrame = Part3.CFrame * CFrame.new(0,0,-7)
		Fix(Part7)
		Part7.CFrame = Part4.CFrame * CFrame.new(0,0,-10)
		Fix(Part8)
		Part8.CFrame = Part5.CFrame * CFrame.new(0,0,-10)
		Fix(Part9)
		Part9.CFrame = Part6.CFrame * CFrame.new(0,0,-10)
		wait(1)
		disappear(Part1)
		disappear(Part2)
		disappear(Part3)
		wait(0.4)
		disappear(Part4)
		disappear(Part5)
		disappear(Part6)
		wait(0.4)
		disappear(Part7)
		disappear(Part8)
		disappear(Part9)
	end
}

return module




