local ring = {}
local hand = require("utils")
local configP1 = require("player1.config")
local configP2 = require("player2.config")
local logicP1 = require("player1.logic")
local logicP2 = require("player2.logic")
local background = "img/rings/ring-1.jpg"
local rockImage = "img/hands/hand-rock.png"
local paperImage = "img/hands/hand-paper.png" 
local scissorsImage = "img/hands/hand-scissors.png" 
local armImage = "img/hands/arm.png"
local forearmImage = "img/hands/forearm.png"
local coinImage = "img/rings/coin_star.png"
local koImage = "img/rings/ko.png"
local leftHand = {
  image,
  positionX,
  positionY,
}
local rightHand = {
  image,
  positionX,
  positionY,
}
local rounds = 10
local widthLifebar
local marginTopLifeBar = 70
local fontFile = "font/Yourmate.ttf"
local lastLeft
local lastRight
local stop = false
local widthScreen
local heightScreen
local factorWidthScale
local factorHeightScale

function ring.load(width, height)
  widthScreen = width
  heightScreen = height
  
  backgroundImage = love.graphics.newImage(background)
  coinImage = love.graphics.newImage(coinImage)
  koImage = love.graphics.newImage(koImage)

  setDimensions()

  setImageHands()

  setPlayers()
  drawPlayerName()
end

function ring.draw()
  drawBackground()
  drawHands()
  drawScoreboard()
  drawPlayerName()
  drawWinner()
end

function setImageHands()
  imageHandRock = love.graphics.newImage(rockImage)
  imageHandPaper = love.graphics.newImage(paperImage)
  imageHandScissors = love.graphics.newImage(scissorsImage)
  imageArm = love.graphics.newImage(armImage)
  imageForearm = love.graphics.newImage(forearmImage)
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
  local scaleX = widthScreen / backgroundImage:getWidth()
  local scaleY = heightScreen / backgroundImage:getHeight()
  
  love.graphics.draw(backgroundImage, 0, 0, 0, scaleX, scaleY)
end

function drawHands()
  if leftHand.image ~= nil and rightHand.image ~= nil then
    scale = factorHeightScale * 0.6

    love.graphics.draw(leftHand.image, factorWidthScale * leftHand.positionX, leftHand.positionY, 0, scale, scale)
    love.graphics.draw(rightHand.image, factorWidthScale * rightHand.positionX, rightHand.positionY, 0, -scale, scale)

    love.graphics.draw(imageForearm, factorWidthScale * 80, factorHeightScale * 687, 0, scale, scale)
    love.graphics.draw(imageArm, factorWidthScale * -20, factorHeightScale * 320, 0, scale, scale)

    love.graphics.draw(imageForearm, factorWidthScale * 918, factorHeightScale * 687, 0, -scale, scale)
    love.graphics.draw(imageArm, factorWidthScale * 1018, factorHeightScale * 320, 0, -scale, scale)
  end
end

function setDimensions()
  factorWidthScale = widthScreen / 1000
  factorHeightScale = heightScreen / 1000
  widthLifebar = factorWidthScale * 400
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

function drawWinner()
  if stop then
    winnerName = players[1].health == 0 and players[2].name or players[1].name
    
    local sizeKo = 0.8
    local font = love.graphics.newFont(fontFile, 54)
    local winnerText = love.graphics.newText(font, winnerName .. " venceu!!!")
    local textWidth = winnerText:getWidth()
    local textHeight = winnerText:getHeight()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(winnerText, (widthScreen - textWidth) / 2, heightScreen - 80 * factorHeightScale)
    love.graphics.draw(koImage, (widthScreen - koImage:getWidth() * sizeKo) / 2, (heightScreen - koImage:getHeight() * sizeKo - 150 * factorHeightScale) / 2, 0, sizeKo, sizeKo)
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
  handY = (heightScreen / 2) - (200 * factorHeightScale)

  if handLeft == hand.HAND.rock then
    leftHand.image = imageHandRock
    leftHand.positionX = 311
    leftHand.positionY = 700
  elseif handLeft == hand.HAND.paper then
    leftHand.image = imageHandPaper
    leftHand.positionX = 311
    leftHand.positionY = 645 
  else 
    leftHand.image = imageHandScissors
    leftHand.positionX = 299
    leftHand.positionY = 650
  end
  
  if handRight == hand.HAND.rock then
    rightHand.image = imageHandRock
    rightHand.positionX = 687
    rightHand.positionY = 700
  elseif handRight == hand.HAND.paper then
    rightHand.image = imageHandPaper
    rightHand.positionX = 687
    rightHand.positionY = 645
  else 
    rightHand.image = imageHandScissors
    rightHand.positionX = 699
    rightHand.positionY = 650
  end
end

return ring
