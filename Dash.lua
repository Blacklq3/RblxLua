      local debris = game:GetService("Debris")
      local character = player.Character
      local hum = character:WaitForChild("Humanoid")
      local rootpart = character:WaitForChild("HumanoidRootPart")	
      local tapped = false
      local time1 = 0.25	
        
       function Animation(Anim)
         local track = hum:LoadAnimation(Anim)
         track.Priority = Enum.AnimationPriority.Movement
         track:Play()	
       end
        
      local keys = {}
      keys[1] = "W"  
      keys[2] = "A"
      keys[3] = "S"
      keys[4] = "D"

      local UIS = game:GetService("UserInputService")
      local debounce = true	
          
        
        function Dashed()
            local bool = Instance.new('BoolValue',workspace)
            bool.Name = "DashedBool"
            bool.Value = true
            debris:AddItem(bool, 0.57)
        end
        
        function DoneDashed()
            local bool = workspace:WaitForChild("DashedBool")
            bool.Value = false
        end
        
        
      function BodyVelocity(Multiplier,Rotation)	
        local bodyvelocity1 = Instance.new('BodyVelocity',rootpart)
        bodyvelocity1.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
        local LCframe = player.Character.HumanoidRootPart.CFrame * CFrame.fromEulerAnglesXYZ(math.rad(0),math.rad(Rotation),math.rad(0))
        bodyvelocity1.Velocity = LCframe.lookVector*Multiplier	
        debris:AddItem(bodyvelocity1, 0.5)	 		
      end
        
        
      function DoDash(Key,Rotation,UIS,debounce,tapped,time1,CD)
       UIS.InputBegan:Connect(function(input,IsTyping)
        if IsTyping then return end
         if input.KeyCode == Enum.KeyCode[Key] and debounce then	
          debounce = false
           if hum:GetState() == Enum.HumanoidStateType.Jumping then return end
            if hum:GetState() == Enum.HumanoidStateType.Freefall then
             if not tapped then 
               tapped = true
               wait(time1)	
               tapped = false
               else		
                Dashed()
                BodyVelocity(40,Rotation)
                wait(0.5)
                DoneDashed()
               end	
                else
                 if not tapped then 
                  tapped = true	
                  wait(time1)
                  tapped = false
                  else		
                   Dashed()
                   BodyVelocity(55,Rotation)
                   wait(0.5)
                   DoneDashed()
                  end
                end
               end
              debounce = true
             end)
           end		
            
         local Count = 0    
        
         


         for i = 1,4 do 
             if Count ~= 270
               DoDash(keys[i],Count,UIS,debounce,tapped,time1,CD)
               Count+= 90
             else 
               DoDash(keys[4],-90,UIS,debounce,tapped,time1,CD)
             end   
         end   
         
    
           