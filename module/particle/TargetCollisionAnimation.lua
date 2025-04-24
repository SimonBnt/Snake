local ResetColor = require("module.interface.ResetColor")

local TargetCollisionAnimation = {}

TargetCollisionAnimation.list = {}

function TargetCollisionAnimation.add(target)
    table.insert(TargetCollisionAnimation.list, {
        x = target.x,
        y = target.y,
        radius = target.radius,
        life = 0.3,
        maxLife = 0.3
    })
end

function TargetCollisionAnimation.update(dt)
    for i = #TargetCollisionAnimation.list, 1, -1 do
        local anim = TargetCollisionAnimation.list[i]
        anim.life = anim.life - dt
        if anim.life <= 0 then
            table.remove(TargetCollisionAnimation.list, i)
        end
    end
end

function TargetCollisionAnimation.draw(r)
    for _, anim in ipairs(TargetCollisionAnimation.list) do
        local progress = anim.life / anim.maxLife
        local alpha = progress
        local size = anim.radius + (1 - progress) * 10

        love.graphics.setColor(1, 0.8, 0, alpha)
        love.graphics.circle("line", anim.x, anim.y, size)
        ResetColor.reset()
    end
end

return TargetCollisionAnimation
