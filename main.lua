local menuScene = require("menu")
local ringScene = require("ring")
local configP1 = require("player1.config")
local configP2 = require("player2.config")
local nextUpdate = 1.0
local winner
local winnerName = ""
local screenWidth = 1920
local screenHeight = 1080
<<<<<<< HEAD
=======
local mkSong = love.audio.newSource("song/mk-song.mp3", "stream")
>>>>>>> 43b59aa027293188493b32b30843c838f22741e9

-- intial config
love.window.setMode(screenWidth, screenHeight, {
      fullscreen = true, -- standard should be true
      vsync = 1,
    }
)

function love.load()
  -- menuScene.loadImage()
  ringScene.load(screenWidth, screenHeight)
  mkSong:play()
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
