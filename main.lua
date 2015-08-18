--[[

File: 		main.lua
Author: 	Daniel "lytedev" Flanagan
Website:	http://dmf.me

Game entry point.

]]--

require("conf")

elapsed = 0
gameSpeed = 0.5

function love.load()
	love.graphics.setBackgroundColor(17, 17, 17, 255)
	gridWidth = 10
	gridHeight = 25
	controlPoint = {gridWidth / 2, 5}

	blockWidth = 3
	blockHeight = 4
	currentBlock = {
		1, 1, 1,
		0, 1, 0,
		0, 1, 0,
		0, 1, 0 
		}
	--[[ 
	currentBlock = {	
		1, 0, 0, 0
		1, 1, 1, 1
		1, 0, 0, 0
		}
	]]--

	grid = {}
	for x = 1,gridWidth do
		for y = 1,gridHeight do
			i = y * gridWidth + x
			grid[i] = 0
		end
	end
	cellHeight = love.graphics.getHeight() / gridHeight
	cellWidth = cellHeight
end

function rotateBlock()
	local tmpBlock = {}
	for y = 0, blockHeight - 1 do
		for x = 0, blockWidth - 1 do
			i = (y * blockWidth) + x + 1
			i2 = (x * blockHeight) + math.abs(y - (blockHeight - 1)) + 1
			print(i2)
			--if i2 <= #currentBlock then 
				tmpBlock[i2] = currentBlock[i]
			--end
		end
	end
	local tmp = blockWidth
	blockWidth = blockHeight
	blockHeight = tmp
	
	currentBlock = tmpBlock
end

function love.update(dt)
	if love.keyboard.isDown("escape") then
		love.event.quit()
	end

	elapsed = elapsed + dt
	local eGameSpeed = gameSpeed
	if love.keyboard.isDown('down', 's') then
		eGameSpeed = eGameSpeed / 20
	end
	if elapsed > eGameSpeed then
		controlPoint[2] = controlPoint[2] + 1
		elapsed = 0
	end
end

function love.keypressed(k)
	if k == 'p' then
		rotateBlock()
	end
	if k == 'a' then 
		controlPoint[1] = controlPoint[1] - 1
	end
	if k == 'd' then 
		controlPoint[1] = controlPoint[1] + 1
	end
end

function checkBlocks()
	for x = 1,gridWidth do
		for y = 1,gridHeight do
			i = y * gridWidth + x
			if grid[i] == 1 then
				
			end
		end
	end

	love.graphics.rectangle("line", controlPoint[1] * cellWidth, controlPoint[2] * cellHeight, blockWidth * cellWidth, blockHeight * cellHeight)
	for i = 1, #currentBlock do
		xOffset = i - math.floor((i - 1) / blockWidth) * blockWidth - 1
		yOffset = math.floor((i - 1) / blockWidth) + 0
		if currentBlock[i] == 1 then
			drawBlock(controlPoint[1] + xOffset, controlPoint[2] + yOffset)
		end
	end

end

function love.draw()
	love.graphics.setColor(255, 255, 255, 255)
	--drawBlock(0, 0)
	--drawBlock(0, 2)

	for x = 1,gridWidth do
		for y = 1,gridHeight do
			i = y * gridWidth + x
			if grid[i] == 1 then
				drawBlock(x, y)
			end
		end
	end

	love.graphics.rectangle("line", controlPoint[1] * cellWidth, controlPoint[2] * cellHeight, blockWidth * cellWidth, blockHeight * cellHeight)
	for i = 1, #currentBlock do
		xOffset = i - math.floor((i - 1) / blockWidth) * blockWidth - 1
		yOffset = math.floor((i - 1) / blockWidth) + 0
		if currentBlock[i] == 1 then
			drawBlock(controlPoint[1] + xOffset, controlPoint[2] + yOffset)
		end
	end
end

function drawBlock(x, y)
	love.graphics.rectangle('fill', x * cellWidth, y * cellHeight, cellWidth, cellHeight)
end
