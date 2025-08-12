local menu = {}

local fontFile = "font/Yourmate.ttf"

function menu.loadImage()
  menuImage = "img/backgrounds/menu.jpg"
  imageData = love.graphics.newImage(menuImage)
end

function menu.drawImage() 
  love.graphics.draw(imageData, 0, 0)
end

function menu.setContent()
  font = love.graphics.newFont(fontFile, 26)
  
  love.graphics.setColor(0, 0, 0, 1)
  
  startGameText = love.graphics.newText(font, "START GAME")
  configGameText = love.graphics.newText(font, "CONFIGURATION")
  exitText = love.graphics.newText(font, "EXIT")

  love.graphics.draw(startGameText, 870, 460)
  love.graphics.draw(configGameText, 840, 510)
  love.graphics.draw(exitText, 920, 560)
  
  love.graphics.setColor(1, 1, 1, 1)
end

return menu
