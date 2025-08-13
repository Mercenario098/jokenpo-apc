local ring = {}
local hand = require("utils")
local configP1 = require("player1.config")
local configP2 = require("player2.config")
local logicP1 = require("player1.logic")
local logicP2 = require("player2.logic")
local background = "img/rings/ring-1.jpg"
local rockImage = "img/hands/rock.png"
local paperImage = "img/hands/paper.png" 
local scissorsImage = "img/hands/scissors.png" 
local leftHandImage
local rightHandImage
local rounds = 10
local widthLifebar = 800
local marginTopLifeBar = 70
local fontFile = "font/Yourmate.ttf"
local lastLeft
local lastRight
local stop = false

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
  drawPlayerName()
end

function ring.draw()
  drawBackground()
  drawHands()
  drawScoreboard()
  drawPlayerName()
end

function ring.update()
  if stop then return end

  result = runFight()

  if result == 1 then
    players[1].wins = players[1].wins + 1
    players[2].health = players[2].health - 1
  elseif result == 2 then
    players[2].wins = players[2].wins + 1
    players[1].health = players[1].health - 1
  end

  if players[1].health == 0 then
    stop = true
  elseif players[2].health == 0 then
    stop = true
  end
end

function drawBackground()
  love.graphics.draw(backgroundImage, 0, 0)
end

function drawHands()
  if leftHandImage ~= nil then
    love.graphics.draw(leftHandImage, 250, 350, 0, 0.30, 0.30)
  end

  if rightHandImage ~= nil then
    love.graphics.draw(rightHandImage, 1670, 350, 0, -0.30, 0.30)
  end
end

function setPlayers()
  local marginHorizontalLiferBar = 50

  colorBlue = {0.2, 0.6, 1}
  colorRed = {1, 0.3, 0.3}
  
    players = {
        {
            name = configP1.PLAYER_NAME,
            health = rounds,
            wins = 0,
            x = marginHorizontalLiferBar,
            y = marginTopLifeBar,
            color = colorBlue
        },
        {
            name = configP2.PLAYER_NAME,
            health = rounds,
            wins = 0,
            x = love.graphics.getWidth() - widthLifebar - marginHorizontalLiferBar,
            y = marginTopLifeBar,
            color = colorRed
        }
    }
end

function drawPlayerName()
  marginBottom = 40
  
  font = love.graphics.newFont(fontFile, 26)

  for i, player in ipairs(players) do
    love.graphics.setColor(1, 1, 1)
      
    textWidth = font:getWidth(player.name)
    playerNameText = love.graphics.newText(font, player.name) 

    if i == 1 then
      love.graphics.draw(playerNameText, player.x, player.y - marginBottom)
    else
      love.graphics.draw(playerNameText,  player.x + widthLifebar - textWidth, player.y - marginBottom)
    end  
  end
end

function drawScoreboard()     
  local height = 30
  local coinSpacing = 30
  
    for i, player in ipairs(players) do        
        -- life bar background
        love.graphics.setColor(0.3, 0.3, 0.3)
        love.graphics.rectangle("fill", player.x, player.y, widthLifebar, height)
        
        -- life bar filled
        love.graphics.setColor(player.color)
        local healthWidth = (player.health / rounds) * widthLifebar
        
        if i == 1 then
            love.graphics.rectangle("fill", player.x, player.y, healthWidth, height)
        else
            love.graphics.rectangle("fill", player.x + (widthLifebar - healthWidth), player.y, healthWidth, height)
        end
        
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", player.x, player.y, widthLifebar, height)
        
        for j = 1, player.wins do
            local coinY = player.y + 40
            
            if i == 1 then
                local coinX = player.x + widthLifebar - (j * coinSpacing + 20)
                love.graphics.draw(coinImage, coinX, coinY, 0, 0.1, 0.1)
            else
                local coinX = player.x + (j-1) * coinSpacing
                love.graphics.draw(coinImage, coinX, coinY, 0, 0.1, 0.1)
            end
        end
    end
end

function runFight()
  handLeft = logicP1.getHand(lastRight)
  handRight = logicP2.getHand(lastLeft)

  lastLeft = handLeft
  lastRight = handRight

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
    leftHandImage = love.graphics.newImage(rockImage)
  elseif handLeft == hand.HAND.paper then
    leftHandImage = love.graphics.newImage(paperImage)
  else 
    leftHandImage = love.graphics.newImage(scissorsImage)
  end
  
  if handRight == hand.HAND.rock then
    rightHandImage = love.graphics.newImage(rockImage)
  elseif handRight == hand.HAND.paper then
    rightHandImage = love.graphics.newImage(paperImage)
  else 
    rightHandImage = love.graphics.newImage(scissorsImage)
  end
end

return ring
