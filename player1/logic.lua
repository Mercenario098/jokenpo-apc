local hand = require("utils")
local logic = {}

--[[
  rock = 1,
  paper = 2, 
  scissors = 3,

  hand.HAND.rock
  hand.HAND.paper
  hand.HAND.scissors
--]]

math.randomseed(os.time())

function logic.getHand(opponentLastHand)
   -- add you logic here
  return math.random(1, 3)
end

return logic
