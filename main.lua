local menuScene = require("menu")
local ringScene = require("ring")
local configP1 = require("player1.config")
local configP2 = require("player2.config")
local nextUpdate = 1.0
local winner
local winnerName = ""

-- intial config
love.window.setMode(1920, 1080, {
      fullscreen = false, -- standard should be true
      vsync = 1,
    }
)

function love.load()
  -- menuScene.loadImage()
  ringScene.load()
end

function love.draw() 
  -- menuScene.drawImage()
  -- menuScene.setContent()
  
  ringScene.draw()
  
  verifyWinner()
  
  love.graphics.print("O vencedor foi: " .. winnerName, 0, 0)
end

function love.update(dt)
  nextUpdate = nextUpdate - dt
  
  if nextUpdate <= 0 then
    nextUpdate = 1.0
    winner = ringScene.runFight()
  end
end

function verifyWinner()
  if winner == 1 then
    winnerName = configP1.PLAYER_NAME
  elseif winner == 2 then
    winnerName = configP2.PLAYER_NAME
  else
    winnerName = "Empate"
  end
end
