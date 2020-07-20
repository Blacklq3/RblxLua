local module = {
	
	
	CeroLocal = function(player,tool,CD,HowLongStun)
		
		local r1 = game.StarterPack.Cero.remotes.r1
		local mouse = player:GetMouse()
        local cancero = false
		local character = player.Character
		local hum = character:WaitForChild("Humanoid")
		local deb = game:GetService("Debris")
		
		local ShouldStop = function()
            local i = 1 
			local SpeedAndJump = {}
			SpeedAndJump[1] = hum.WalkSpeed
			SpeedAndJump[2] = hum.JumpPower  
			
	      spawn(function()
            for i = 1,HowLongStun do
			 wait(0.1) 
			 hum.AutoRotate = false
		     hum.WalkSpeed = 0
			 hum.JumpPower = 0	
             i+= 1       
			end    
		  end)	
			
           spawn(function()
			 wait(HowLongStun/10 + 0.4)  
			 hum.AutoRotate = true  
             hum.WalkSpeed = SpeedAndJump[1]
			 hum.JumpPower = SpeedAndJump[2]  
		   end) 
       end  
		
		local CANFIRE = function()
			if tool:IsDescendantOf(player.Character) then 
			  return true
			else
			  return false
			end	
		end
		
       -- don't mind
		mouse.Button1Down:Connect(function()
		  if CANFIRE() then	
			if cancero ~= true then 
		    cancero = true	
			ShouldStop()
			wait(0.3)	
			r1:InvokeServer(player,tool)	
			wait(CD)
			cancero = false	
			end
		  elseif CANFIRE() == false then return end		
        end)
		
		
		
		
		
	end;
	
	
	CeroServer = function(AudioId,Volume,AreaVolume,dmg)
		local r1 = game.StarterPack.Cero.remotes.r1
		local deb = game:GetService("Debris")
		local repstorage = game:GetService("ReplicatedStorage")
		
		
		local animation = function()
			
		end
		
		
		local Audio = function(rootpart)      
		  local Part = Instance.new('Part',workspace)
		  Part.Transparency = 1	
		  Part.Anchored = true	
		  Part.CanCollide = false
		  local sound = Instance.new('Sound',Part)	
		  sound.SoundId = AudioId
		  sound.Volume = Volume	
		  sound.EmitterSize = AreaVolume	
		  Part.Position = rootpart.Position	  
		  deb:AddItem(Part,2)
		end
		
		
		
		local Damage = function(Thing,player)
			local hitbox = game.StarterPack.Cero.hitbox:Clone()
			hitbox.Parent = workspace
			hitbox.CFrame = Thing.CFrame
			local debounce = true
			deb:AddItem(hitbox, 2)
			hitbox.Touched:Connect(function(h)
		      if h.Parent:FindFirstChild('Humanoid')and h.Parent.Name ~= player.Name and debounce then
		        debounce = false
			    local Enemy = h.Parent.Humanoid
			    Enemy:TakeDamage(dmg)
		      end
	       end)
		end
		
		
		
		
		
		local CeroEffects = function(Character,player)
			local TweenService = game:GetService("TweenService")
			local sphere = game.StarterPack.Cero.effects.Sphere:Clone()
			local blast = game.StarterPack.Cero.effects.Blast:Clone()
			local blastE = game.StarterPack.Cero.effects.MeshPart:Clone()
			local tweeninf1 = TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
		    local tweeninf2 = TweenInfo.new(0.3,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
            local tweeninf3 = TweenInfo.new(0.2,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
			local goals1 = {Size = sphere.Size * 1.55} 
			local goals2 = {Size = blastE.Size + Vector3.new(blastE.Size.X*2,blastE.Size.Y*1.2,0); Transparency = 0.7}
            local goals3 = {Size = blast.Size + Vector3.new(blast.Size.X*2,blast.Size.Y*1.2,0); Transparency = 1}
            local goals4 = {Size = blastE.Size*1.2 + Vector3.new(blastE.Size.X,blastE.Size.Y*2,0); Transparency = 1}
			local tween1 = TweenService:Create(sphere,tweeninf1,goals1)
			local tween2 = TweenService:Create(blastE,tweeninf2,goals2)
            local tween3 = TweenService:Create(blast,tweeninf2,goals3)
            local newtween = TweenService:Create(blastE,tweeninf3,goals4)
			sphere.Parent = workspace
			sphere.CFrame = Character.Head.CFrame * CFrame.new(0,0,-4.5)
			tween1:Play()
			deb:AddItem(sphere, 1)
			wait(1)
			blast.Parent = workspace
			blastE.Parent = workspace
			blast.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0,2,-27)
			blastE.CFrame = blast.CFrame
		   spawn(function()
	          for i = 1,20 do   
	           wait()
	           i+= 1
	           blastE.CFrame = blastE.CFrame * CFrame.fromEulerAnglesXYZ(math.rad(0),math.rad(0),math.rad(i+5)) 
		        if i == 19 then 
		        newtween:Play()	
		        end	
	          end	
		   end)
		  Damage(blast,player)
          tween2:Play()
		  tween3:Play()
		  deb:AddItem(blast, 2)
		  deb:AddItem(blastE, 2)	
		end
		
		
		
		
		r1.OnServerInvoke = function(player,tool)
		  print("Works1")
		  local character = player.Character
		  local rootpart = character:WaitForChild("HumanoidRootPart")	
		  if repstorage.Skills.IsFire.Value ~= 1 then 
			repstorage.Skills.IsFire.Value = 1	
			print("works2")
		    Audio(rootpart)	
			CeroEffects(character,player)	
		    wait()
			repstorage.Skills.IsFire.Value = 0	
		  end
		end
	end;
	
	
}
