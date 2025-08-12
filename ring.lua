local ring = {}
local hand = require("utils")
local configP1 = require("player1.config")
local configP2 = require("player2.config")
local logicP1 = require("player1.logic")
local logicP2 = require("player2.logic")
local handLeft
local handRight
local background = "img/rings/ring-1.jpg"
local rockImage = "img/hands/rock.png"
local paperImage = "img/hands/paper.png" 
local scissorsImage = "img/hands/scissors.png" 
local leftImage = love.graphics.newImage(rockImage)
local rightImage = love.graphics.newImage(scissorsImage)
local rounds = 10
local widthLifebar = 800
local marginLifeBar = 50

--[[
  returns
  draw -> 0
  left win -> 1
  righ win -> 2
--]]

function ring.load() 
  backgroundImage = love.graphics.newImage(background)
  
  coinImage = love.graphics.newImage("img/rings/coin_star.png")
  
  setPlayers()
end

function ring.draw()
  love.graphics.draw(backgroundImage, 0, 0)
  love.graphics.draw(leftImage, 250, 350, 0, 0.30, 0.30)
  love.graphics.draw(rightImage, 1670, 350, 0, -0.30, 0.30)
  
  setupScoreboard()
end

function setPlayers()
    players = {
        {
            name = configP1.PLAYER_NAME,
            health = rounds,
            wins = 2,
            x = marginLifeBar,
            y = 50,
            color = {0.2, 0.6, 1}
        },
        {
            name = configP2.PLAYER_NAME,
            health = rounds,
            wins = 3,
            x = love.graphics.getWidth() - widthLifebar - marginLifeBar,
            y = 50,
            color = {1, 0.3, 0.3}
        }
    }
end

function setupScoreboard() 
  for i, player in ipairs(players) do
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(player.name, player.x, player.y - 30)
        
        -- life bar background
        love.graphics.setColor(0.3, 0.3, 0.3)
        love.graphics.rectangle("fill", player.x, player.y, widthLifebar, 30)
        
        -- life bar filled
        love.graphics.setColor(player.color)
        local healthWidth = (player.health / rounds) * widthLifebar
        love.graphics.rectangle("fill", player.x, player.y, healthWidth, 30)
        
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", player.x, player.y, widthLifebar, 30)
        
        for j = 1, player.wins do
            local coinX = player.x + (j-1) * 30
            local coinY = player.y + 40
            
            love.graphics.draw(coinImage, coinX, coinY, 0, 0.1, 0.1)
        end
    end
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
