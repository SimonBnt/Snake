local Snake = require("module.character.Snake")

local Control = require("module.control.Control")

local BorderCollision = require("module.interface.BorderCollision")
local ResetColor = require("module.interface.ResetColor")
local Score = require("module.interface.Score")
local Timer = require("module.interface.Timer")

local Particle = require("module.particle.Particle")
local TargetCollisionAnimation = require("module.particle.TargetCollisionAnimation")

local GameState = require("module.state.GameState")

local Target = require("module.target.Target")


function love.load()   
    screenWidth = 1280
    screenHeight = 720
    timer = 60
    gameState = ""

    snake = Snake:new()

    Target.list = {}
    Particle.list = {}
    TargetCollisionAnimation.list = {}

    math.randomseed(os.time())
end

function love.update(dt)
    timer = timer - dt

    if timer <= 0 then
        gameState = "gameIsOver"
    elseif snake.score >= 100 then
        gameState = "win"
    else
        gameState = "gameIsRunning"
    end

    if gameState == "gameIsRunning" then
        Control.handle(dt)
        Target.spawn(screenWidth, screenHeight)
        BorderCollision.check(snake, screenWidth, screenHeight)

        for i = #Target.list, 1, -1 do
            local target = Target.list[i]
            if Target.checkCollision(snake, target) then
                snake.score = snake.score + 1
                TargetCollisionAnimation.add(target)
                table.remove(Target.list, i)
            end
        end

        Particle.update(dt, snake)
        TargetCollisionAnimation.update(dt)
    end
end

function love.draw()
    if gameState == "gameIsRunning" then
        Timer.draw(timer, screenWidth)
        Score.draw(snake.score)
        Snake:draw(snake)
        Particle.draw()
        Target.draw()
        TargetCollisionAnimation.draw()
    elseif gameState == "gameIsOver" then
        GameState.gameOver(snake, screenWidth)
    elseif gameState == "win" then
        GameState.win()
    end
end
