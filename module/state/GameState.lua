local GameState = {}

function GameState.gameOver(snake, screenWidth)
    local gameStateFont = love.graphics.newFont(64)
    local scoreFont = love.graphics.newFont(28)
    love.graphics.setFont(gameStateFont)

    local text = "Game Over"
    local textWidth = gameStateFont:getWidth(text)
    local posX = (screenWidth / 2) - textWidth / 2
    local posY = 360

    love.graphics.print(text, posX, posY)

    love.graphics.setFont(scoreFont)
    local scoreText = "Score: " .. snake.score
    local scoreWidth = scoreFont:getWidth(scoreText)
    love.graphics.print(scoreText, (screenWidth / 2) - scoreWidth / 2, posY + 80)
end

function GameState.win(snake, screenWidth)
    local gameStateFont = love.graphics.newFont(64)
    local scoreFont = love.graphics.newFont(28)
    love.graphics.setFont(gameStateFont)

    local gameStateText = "Win"
    local textWidth = gameStateFont:getWidth(gameStateText)
    local textHeight = gameStateFont:getHeight(gameStateText)

    local posX = (screenWidth / 2) - textWidth / 2
    local posY = 360

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(gameStateText, posX, posY)

    love.graphics.setFont(scoreFont)
    local scoreText = "Score: " .. snake.score
    local scoreWidth = scoreFont:getWidth(scoreText)
    love.graphics.print(scoreText, (screenWidth / 2) - scoreWidth / 2, posY + 80)
end

return GameState
