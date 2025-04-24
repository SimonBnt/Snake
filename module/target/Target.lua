local ResetColor = require("module.interface.ResetColor")

local Target = {}

-- Listes des cibles
Target.normallist = {}
Target.maxNormal = 20
Target.redList = {}
Target.maxRed = 20

-- Fonction pour faire apparaître une nouvelle cible normale
function Target.spawn(screenWidth, screenHeight)
    if #Target.normallist < Target.maxNormal then
        local newTarget = {
            x = math.random(20, screenWidth - 20),
            y = math.random(100, screenHeight - 20),
            radius = 6
        }
        table.insert(Target.normallist, newTarget)
    end
end

-- Fonction pour dessiner les cibles normales
function Target.draw()
    for _, t in ipairs(Target.normallist) do
        love.graphics.setColor(1, 0.8, 0.2)
        love.graphics.circle("fill", t.x, t.y, t.radius)
        ResetColor.reset()
    end
end

-- Fonction pour faire apparaître une nouvelle cible rouge
function Target.spawnRed(screenWidth, screenHeight)
    if #Target.redList < Target.maxRed then
        local redTarget = {
            x = math.random(20, screenWidth - 20),
            y = math.random(100, screenHeight - 20),
            radius = 6
        }
        table.insert(Target.redList, redTarget)
    end
end

-- Fonction pour dessiner une nouvelle cible rouge
function Target.drawRed()
    for _, t in ipairs(Target.redList) do
        love.graphics.setColor(1, 0.1, 0.1)
        love.graphics.circle("fill", t.x, t.y, t.radius)
        ResetColor.reset()
    end
end

-- Fonction pour v"rifier si une collision est détectée entre le snake et une cible
function Target.checkCollision(snake, target)
    return snake.posX < target.x + target.radius and
           snake.posX + snake.width > target.x - target.radius and
           snake.posY < target.y + target.radius and
           snake.posY + snake.height > target.y - target.radius
end

return Target
