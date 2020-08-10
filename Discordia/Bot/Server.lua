-- Packages 
local discordia = require('discordia')
local BotPackage = require('BotSettings')
local timer = require('timer')
--Packages

--objects
local client = discordia.Client()
local Bot = BotPackage:New()
--objects

local BotSettings = Bot:GiveSettings()
local BotCommands = Bot:Commands()
local debounce = true


local Users = {}

local function CommandOutput(debounce,message,command,Time,msgauthor)
  for i,v in pairs(Users) do 
    if msgauthor ~= v then 
      message.channel:send(command.output)
      timer.sleep(Time) 
    end
  end 
end  

client:on('messageCreate', function(message)
  if string.lower(string.sub(message.content,1,5)) == BotSettings.Prefix..BotCommands.help.cmd and debounce == true then    
     debounce = false 
     CommandOutput(debounce,message,BotCommands.help,5000)
     table.insert(Users,message.author)
     debounce = true
  elseif string.lower(string.sub(message.content,1,5)) == BotSettings.Prefix..BotCommands.meme.cmd and debounce == true then  
     debounce = false
     CommandOutput(debounce,message,BotCommands.meme,5000)
     table.insert(Users,message.author)
     debounce = true
  end  
end)


client:run(BotSettings.Token) 