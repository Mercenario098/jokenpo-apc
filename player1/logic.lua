local hand = require("utils")
local logic = {}

math.randomseed(os.time())

function logic.getHand(opponentLastHand)
   -- add you logic here
  return math.random(1, 3)
end

return logic
