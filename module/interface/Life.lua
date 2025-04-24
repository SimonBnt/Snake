local Life = {}

function Life.draw()
    local lifeFont = love.graphics.newFont(20)
    love.graphics.setFont(lifeFont)
    love.graphics.print("Life: " .. snake.life, 10, 40)
end

return Life
