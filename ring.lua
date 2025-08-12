local ring = {}
local hand = require("utils")
local configP1 = require("player1.config")
local configP2 = require("player2.config")
local logicP1 = require("player1.logic")
local logicP2 = require("player2.logic")
local hand = require("utils")
local handLeft
local handRight
local background = "img/rings/ring-1.jpg"
local rockImage = "img/hands/rock.png"
local paperImage = "img/hands/paper.png" 
local scissorsImage = "img/hands/scissors.png" 
local leftImage = love.graphics.newImage(rockImage)
local rightImage = love.graphics.newImage(scissorsImage)

--[[
  returns
  draw -> 0
  left win -> 1
  righ win -> 2
--]]

function ring.load() 
  backgroundImage = love.graphics.newImage(background)
end

function ring.draw()
  love.graphics.draw(backgroundImage, 0, 0)
  love.graphics.draw(leftImage, 250, 350, 0, 0.30, 0.30)
  love.graphics.draw(rightImage, 1670, 350, 0, -0.30, 0.30)
end

function ring.runFight()
  handLeft = logicP1.getHand()
  handRight = logicP2.getHand()
  
  updateHands()
  
  if (handLeft == handRight) then
    return 0
  end
  
  if (handLeft == hand.HAND.rock and handRight == hand.HAND.scissors) or
     (handLeft == hand.HAND.scissors and handRight == hand.HAND.paper) or
     (handLeft == hand.HAND.paper and handRight == hand.HAND.rock) then
       return 1
  else 
    return 2
  end
end

function updateHands()
  if handLeft == hand.HAND.rock then
    leftImage = love.graphics.newImage(rockImage)
  elseif handLeft == hand.HAND.paper then
    leftImage = love.graphics.newImage(paperImage)
  else 
    leftImage = love.graphics.newImage(scissorsImage)
  end
  
  if handRight == hand.HAND.rock then
    rightImage = love.graphics.newImage(rockImage)
  elseif handRight == hand.HAND.paper then
    rightImage = love.graphics.newImage(paperImage)
  else 
    rightImage = love.graphics.newImage(scissorsImage)
  end
end

return ring
