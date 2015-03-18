--[[
	Run this file from root dir of repository with
	dofile('test/test_model.lua')
]]

dofile('env.lua')
dofile('model.lua')
dofile('criterion.lua')

channels = {}

for i = 1,2 do
	channels[i] = torch.randn(1,100)
end

x = model:forward(channels)
y = criterion:forward(x,targets)

