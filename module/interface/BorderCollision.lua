local BorderCollision = {}

function BorderCollision.check(snake, screenWidth, screenHeight)
    if snake.posX < 0 then
        snake.posX = 0
    elseif snake.posX + snake.width > screenWidth then
        snake.posX = screenWidth - snake.width
    end

    if snake.posY < 0 then
        snake.posY = 0
    elseif snake.posY + snake.height > screenHeight then
        snake.posY = screenHeight - snake.height
    end
end

return BorderCollision
