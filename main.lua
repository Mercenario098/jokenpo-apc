local menuScene = require("menu")

-- intial config
love.window.setMode(1920, 1080, {
      fullscreen = false, -- standard should be true
      vsync = 1,
    }
)

function love.load()
  menuScene.loadImage()
end

function love.draw() 
  menuScene.drawImage()
  menuScene.setContent()
end

--[[
local configP1 = require("player1.config")
local configP2 = require("player2.config")

print(configP1.PLAYER_NAME)
print(configP2.PLAYER_NAME)
]]--