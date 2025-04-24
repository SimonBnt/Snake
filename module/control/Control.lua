local Control = {}

function Control.handle(dt)
    if love.keyboard.isDown("up") then
        snake.posY = snake.posY + -4
    elseif love.keyboard.isDown("right") then
        snake.posX = snake.posX + 4
    elseif love.keyboard.isDown("down") then
        snake.posY = snake.posY + 4
    elseif love.keyboard.isDown("left") then
        snake.posX = snake.posX + -4
    end
end

return Control