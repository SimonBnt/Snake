-- Import de tout les modules
-- module de création d'un snake
local Snake = require("module.character.Snake")

-- module de gestion des controls
local Control = require("module.control.Control")

-- module pour gérer l'affichage de l'interface
local BorderCollision = require("module.interface.BorderCollision")
local ResetColor = require("module.interface.ResetColor")
local Score = require("module.interface.Score")
local Timer = require("module.interface.Timer")
local Life = require("module.interface.Life")

-- module pour gérer la création et l'affichage des particules et animations
local Particle = require("module.particle.Particle")
local TargetCollisionAnimation = require("module.particle.TargetCollisionAnimation")

-- module pour gérer l'état actuel du jeu
local GameState = require("module.state.GameState")

-- module pour gérer la création, la mise a jour et l'affichage de cibles pour obtenir des points mais aussi qui font perdre de la vie
local Target = require("module.target.Target")

function love.load()   
    screenWidth = 1280
    screenHeight = 720
    timer = 60
    gameState = ""

    snake = Snake:new()

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

         -- Apparition des cibles normales et rouges
        Target.spawn(screenWidth, screenHeight)
        Target.spawnRed(screenWidth, screenHeight)

        -- Vérification des collisions avec les bords
        BorderCollision.check(snake, screenWidth, screenHeight)

        -- Vérification des collisions avec les cibles normales
        for i = #Target.normallist, 1, -1 do
            local target = Target.normallist[i]
            if Target.checkCollision(snake, target) then
                snake.score = snake.score + 1
                TargetCollisionAnimation.add(target)
                table.remove(Target.normallist, i) -- Suppression de la cible après collision
            end
        end

        -- Vérification des collisions avec les cibles rouges
        for i = #Target.redList, 1, -1 do
            local target = Target.redList[i]
            if Target.checkCollision(snake, target) then
                snake.life = snake.life - 1
                TargetCollisionAnimation.add(target)
                table.remove(Target.redList, i)  -- Suppression de la cible après collision
            end
        end

        -- Mise à jour des particules et des animations
        Particle.update(dt, snake)
        TargetCollisionAnimation.update(dt)

        if snake.life == 0 then
            gameState = "gameIsOver"
            timer = 0
        end
    end
end

function love.draw()
    if gameState == "gameIsRunning" then
        Timer.draw(timer, screenWidth)
        Score.draw(snake.score)
        Snake:draw(snake)
        Particle.draw()
        Target.draw()
        Target.drawRed()
        TargetCollisionAnimation.draw()
        Life.draw()
    elseif gameState == "gameIsOver" then
        GameState.gameOver(snake, screenWidth)
    elseif gameState == "win" then
        GameState.win()
    end
end
