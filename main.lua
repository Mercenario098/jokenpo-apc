local menuScene = require("menu")
local ringScene = require("ring")
local configP1 = require("player1.config")
local configP2 = require("player2.config")
local nextUpdate = 1.0
local winner
local winnerName = ""
local screenWidth = Sysmtem.getScreenWidth() or 1280
local screenHeight = Sysmtem.getScreenHeight() or 720

-- intial config
love.window.setMode(screenWidth, screenHeight, {
      fullscreen = false, -- standard should be true
      vsync = 1,
    }
)

function love.load()
  -- menuScene.loadImage()
  ringScene.load(screenWidth, screenHeight)
end

function love.draw() 
  -- menuScene.drawImage()
  -- menuScene.setContent()
  
  ringScene.draw()
end

function love.update(dt)
  nextUpdate = nextUpdate - dt
  
  if nextUpdate <= 0 then
    nextUpdate = 1.0
    ringScene.update()
  end
end
