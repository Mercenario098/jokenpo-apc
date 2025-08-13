local hand = require("utils")
local logic = {}

math.randomseed(os.time())

function logic.getHand() -- is hand from last time
  return math.random(1, 3)
end

return logic
