local ResetColor = require("module.interface.ResetColor")

local Particle = {}

Particle.list = {}

function Particle.update(dt, snake)
    table.insert(Particle.list, {
        x = snake.posX + snake.width / 2,
        y = snake.posY + snake.height / 2,
        radius = 2,
        life = 1
    })

    for i = #Particle.list, 1, -1 do
        local p = Particle.list[i]
        p.life = p.life - dt
        if p.life <= 0 then
            table.remove(Particle.list, i)
        end
    end
end

function Particle.draw()
    for _, p in ipairs(Particle.list) do
        love.graphics.setColor(0, 0.8, 1, p.life)
        love.graphics.rectangle("fill", p.x, p.y, 2, 2, p.radius)
        ResetColor.reset()
    end
end

return Particle
