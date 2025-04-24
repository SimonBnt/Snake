local Timer = {}

function Timer.draw(timer, screenWidth)
    local timerFont = love.graphics.newFont(32)
    love.graphics.setFont(timerFont)
    local timerText = string.format("%.2f", timer)
    local textWidth = timerFont:getWidth(timerText)
    local posX = (screenWidth / 2) - (textWidth / 2)
    local posY = 20

    love.graphics.print(timerText, posX, posY)
end

return Timer
