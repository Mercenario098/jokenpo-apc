local hand = require("utils")
local logic = {}
local configP2 = require("player2.config")

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
  if configP2 == hand.HAND.rock then
    return hand.HAND.paper
  end
  elseif configP2 == hand.HAND.poper then
    return hand.HAND.scissors
  end
  elseif configP2 == hand.HAND.scissors then
  return hand.HAND.rock
end

return logic
 