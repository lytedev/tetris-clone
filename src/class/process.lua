--[[

File: 		process.lua
Author: 	Daniel "lytedev" Flanagan
Website:	http://dmf.me

Handles a process.

]]--

local Class = require("lib.hump.class")

local Process = Class{}

function Process:init()

end

function Process:start()
	print("Starting Process " .. table.address(self))
	return true
end

function Process:update(dt)

end

function Process:draw()

end

function Process:finish()

end

return Process
