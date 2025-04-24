local ResetColor = require("module.interface.ResetColor")

local Target = {}

Target.list = {}
Target.max = 20

function Target.spawn(screenWidth, screenHeight)
    if #Target.list < Target.max then
        local newTarget = {
            x = math.random(20, screenWidth - 20),
            y = math.random(20, screenHeight - 20),
            radius = 6
        }
        table.insert(Target.list, newTarget)
    end
end

function Target.draw()
    for _, t in ipairs(Target.list) do
        love.graphics.setColor(1, 0.8, 0.2)
        love.graphics.circle("fill", t.x, t.y, t.radius)
        ResetColor.reset()
    end
end

function Target.checkCollision(snake, target)
    return snake.posX < target.x + target.radius and
           snake.posX + snake.width > target.x - target.radius and
           snake.posY < target.y + target.radius and
           snake.posY + snake.height > target.y - target.radius
end

return Target
