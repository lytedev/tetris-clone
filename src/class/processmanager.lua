--[[

File: 		processmanager.lua
Author: 	Daniel "lytedev" Flanagan
Website:	http://dmf.me

Manages a group of processes.

]]--

local Process = require("src.class.process")
local Class = require("lib.hump.class")

local ProcessManager = Class{}

function ProcessManager:init()
	self.processList = {}
end

function ProcessManager:addProcess(process)
	if process == nil then return end
	if process:start() then
		self.processList[table.address(process)] = process
		return true
	end
	return false
end

function ProcessManager:update(dt)
	local pairs = pairs
	for k, v in pairs(self.processList) do
		v:update(dt);
	end
end

function ProcessManager:draw(dt)
	local pairs = pairs
	for k, v in pairs(self.processList) do
		v:draw(dt);
	end
end

function ProcessManager:removeProcess(process)
	self.processList:remove(table.address(process))
end

return ProcessManager
