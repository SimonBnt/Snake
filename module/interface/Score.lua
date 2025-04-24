local Score = {}

function Score.draw(score)
    local font = love.graphics.newFont(20)
    love.graphics.setFont(font)
    love.graphics.print("Score: " .. score, 10, 10)
end

return Score