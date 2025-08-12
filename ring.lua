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
local leftImage = love.graphics.newImage(rockImage)
local rightImage = love.graphics.newImage(scissorsImage)
local rounds = 10
local widthLifebar = 800
local marginHorizontalLiferBar = 50
local marginTopLifeBar = 70
local fontFile = "font/Yourmate.ttf"

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
  love.graphics.draw(backgroundImage, 0, 0)
  love.graphics.draw(leftImage, 250, 350, 0, 0.30, 0.30)
  love.graphics.draw(rightImage, 1670, 350, 0, -0.30, 0.30)
  
  setupScoreboard()
  drawPlayerName()
end

function setPlayers()
  colorBlue = {0.2, 0.6, 1}
  colorRed = {1, 0.3, 0.3}
  
    players = {
        {
            name = configP1.PLAYER_NAME,
            health = rounds-9,
            wins = 12,
            x = marginHorizontalLiferBar,
            y = marginTopLifeBar,
            color = colorBlue
        },
        {
            name = configP2.PLAYER_NAME,
            health = rounds -2,
            wins = 10,
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

function setupScoreboard()     
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
