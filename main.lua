function love.load()   
    screenWidth = 1280
    screenHeight = 720
    timer = 60
    gameState = ""

    snake = {
        name = joueur,
        posX = 524,
        posY = 344, 
        width = 16,
        height = 16,
        radius = 4,

        velocity = { x = 0, y = 0 },
        speed = 100,
    
        life = 3,
    
        score = 0,
    }

    targetList = {}
    maxTarget = 20

    redTargetList = {}
    maxRedTarget = 20

    particleList = {}
    animationList = {}

    function resetColor()
        love.graphics.setColor(1,1,1)
    end

    function handleControl(dt)
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

    function handleScreenCollision()
        -- Bord gauche
        if snake.posX < 0 then
            snake.posX = 0
        end

        -- Bord droit
        if snake.posX + snake.width > screenWidth then
            snake.posX = screenWidth - snake.width
        end

        -- Bord haut
        if snake.posY < 0 then
            snake.posY = 0
        end

        -- Bord bas
        if snake.posY + snake.height > screenHeight then
            snake.posY = screenHeight - snake.height
        end
    end

    function drawTimer()
        local timerFont = love.graphics.newFont(32)
        love.graphics.setFont(timerFont)
    
        local timerText = string.format("%.2f", timer)
        local textWidth = timerFont:getWidth(timerText)
        local textHeight = timerFont:getHeight(timerText)
    
        local posX = (screenWidth / 2) - textWidth / 2
        local posY = 20 - textHeight / 2 
    
        love.graphics.print(timerText, posX, posY)
    end
    
    function DrawSnake()
        love.graphics.setColor(0,0.8,1)
        love.graphics.rectangle("fill", snake.posX, snake.posY, snake.width, snake.height, snake.radius)
        resetColor()
    end

    function drawSnakeLife()
        local lifeFont = love.graphics.newFont(20)
        love.graphics.setFont(lifeFont)
        love.graphics.print("Life: " .. snake.life, 0, 24)
    end

    function updateParticle(dt)
        table.insert(particleList, {
            x = snake.posX + snake.width / 2,
            y = snake.posY + snake.height / 2,
            radius = 2,
            life = 1
        })
    
        for i = #particleList, 1, -1 do
            local p = particleList[i]
            p.life = p.life - dt
            if p.life <= 0 then
                table.remove(particleList, i)
            end
        end
    end

    function drawParticle()
        for _, p in ipairs(particleList) do
            love.graphics.setColor(0, 0.8, 1, p.life)
            love.graphics.rectangle("fill", p.x, p.y, 2, 2, p.radius)
            resetColor()
        end
    end

    function drawScore()
        local scoreFont = love.graphics.newFont(20)
        love.graphics.setFont(scoreFont)
        love.graphics.print(snake.score, 0, 0)
    end

    function spawnTarget()
        if #targetList < maxTarget then
            local x = math.random(20, 1260)
            local y = math.random(20, 700)
            local target = {
                x = x,
                y = y,
                originX = x,
                originY = y,
                radius = 6,
                moveRange = 40,
                vx = (math.random(0, 1) == 0 and -1 or 1) * 30, -- vitesse px/s
                vy = (math.random(0, 1) == 0 and -1 or 1) * 30
            }
            table.insert(targetList, target)
        end
    end
    

    function spawnRedTarget()
        if #redTargetList < maxRedTarget then
            local x = math.random(20, 1260)
            local y = math.random(20, 700)
            local redTarget = {
                x = x,
                y = y,
                originX = x,
                originY = y,
                radius = 6,
                moveRange = 40,
                vx = (math.random(0, 1) == 0 and -1 or 1) * 30,
                vy = (math.random(0, 1) == 0 and -1 or 1) * 30
            }
            table.insert(redTargetList, redTarget)
        end
    end

    function drawTarget()
        for i, t in ipairs(targetList) do
            love.graphics.setColor(1,0.8,0.2)
            love.graphics.circle("fill", t.x, t.y, t.radius)
            resetColor()
        end
    end

    function drawRedTarget()
        for i, t in ipairs(redTargetList) do
            love.graphics.setColor(1, 0.1, 0.1) -- rouge
            love.graphics.circle("fill", t.x, t.y, t.radius)
            resetColor()
        end
    end

    function checkCollision(snake, target)
        return snake.posX < target.x + target.radius and
        snake.posX + snake.width > target.x - target.radius and
        snake.posY < target.y + target.radius and
        snake.posY + snake.height > target.y - target.radius
    end

    function updateTarget()
        for i = #targetList, 1, -1 do
            local target = targetList[i]

            if checkCollision(snake, target) then
                snake.score = snake.score + 1

                table.insert(animationList, {
                    x = target.x,
                    y = target.y,
                    radius = target.radius,
                    life = 0.3,
                    maxLife = 0.3
                })

                table.remove(targetList, i)
            end
        end
    end

    function updateRedTarget()
        for i = #redTargetList, 1, -1 do
            local target = redTargetList[i]
            if checkCollision(snake, target) then
                snake.life = snake.life - 1
    
                table.insert(animationList, {
                    x = target.x,
                    y = target.y,
                    radius = target.radius,
                    life = 0.3,
                    maxLife = 0.3
                })
    
                table.remove(redTargetList, i)
    
                if snake.life <= 0 then
                    gameState = "gameIsOver"
                    timer = 0
                end
            end
        end
    end

    function updateCollisionAnimation(dt)
        for i = #animationList, 1, -1 do
            local anim = animationList[i]
            anim.life = anim.life - dt
            if anim.life <= 0 then
                table.remove(animationList, i)
            end
        end
    end

    function drawCollisionAnimation()
        for _, anim in ipairs(animationList) do
            local progress = anim.life / anim.maxLife
            local alpha = progress
            local size = anim.radius + (1 - progress) * 10
    
            love.graphics.setColor(1, 0.8, 0, alpha)
            love.graphics.circle("line", anim.x, anim.y, size)
            resetColor()
        end
    end

    function gameOver()
        local gameStateFont = love.graphics.newFont(64)
        local scoreFont = love.graphics.newFont(28)
        love.graphics.setFont(gameStateFont)
    
        local gameStateText = "Game Over"
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

    function win()
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
end

function love.update(dt)
    timer = timer - dt

    if timer > 0 then
        gameState = "gameIsRunning"
    else 
        gameState = "gameIsOver"
    end

    if snake.score == 100 then
        gameState = "win"
    end

    if gameState == "gameIsRunning" then
        handleControl(dt)
        spawnTarget()
        spawnRedTarget()              
        updateTarget()
        updateRedTarget()            
        updateParticle(dt)
        updateCollisionAnimation(dt)
        handleScreenCollision()
    end
    
end

function love.draw()
    if gameState == "gameIsRunning" then
        drawTimer()
        drawScore()
        drawTarget()
        drawRedTarget()
        DrawSnake()
        drawParticle()
        drawCollisionAnimation()
        drawSnakeLife()
    elseif gameState == "gameIsOver" then
        gameOver()
    elseif gameState == "win" then
        win()
    end
end
