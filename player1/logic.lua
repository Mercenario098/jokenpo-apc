local logic = {}
local hand = require("utils")

function logic.getHand() -- is hand from last time
  return hand.HAND.scissors
end

return logic
