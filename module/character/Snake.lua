local ResetColor = require("module.interface.ResetColor")

local Snake = {}
Snake.__index = Snake

function Snake:new(name, posX, posY)
    local self = setmetatable({}, Snake)

    self.name = name or ""
    self.posX = posX or 524
    self.posY = posY or 344
    self.width = 16
    self.height = 16
    self.radius = 4

    self.velocity = { x = 0, y = 0 }
    self.speed = 100

    self.life = 3

    self.score = 0

    return self
end

function Snake:draw(snake)
    love.graphics.setColor(0,0.8,1)
    love.graphics.rectangle("fill", snake.posX, snake.posY, snake.width, snake.height, snake.radius, snake.radius)
    ResetColor.reset()
end

return Snake