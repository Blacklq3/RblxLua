local Bot = {}

function Bot:New(obj)
  obj = obj or {}
  setmetatable(obj,Bot)
  self.__index = self
  return obj
end    

function Bot:GiveSettings()
  local settings = {}
  settings["Token"] = require('BotToken')()
  settings["Prefix"] = ":"
  return settings
end   

function Bot:Commands()
   local Commands = { 
     help = require("./Commands/help");
     meme = require("./Commands/Meme")

   }
   return Commands
end

return Bot