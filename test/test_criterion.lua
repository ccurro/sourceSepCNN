--[[
	Run this file from root dir of repository with
	dofile('test/test_criterion.lua')
]]

dofile('env.lua')
dofile('criterion.lua')

output = {}
channels = {}

for i = 1,4 do
	channels[i] = torch.randn(1,100)
end

--[[
	channels[1] = Demix 1
	channels[2] = Demix 2
	channels[3] = Mix   1
	channels[4] = Mix   2
]]

output[1] = torch.cat(channels[1],channels[2],1)
output[2] = torch.cat(channels[1],channels[3],1)
output[3] = torch.cat(channels[1],channels[4],1)
output[4] = torch.cat(channels[2],channels[3],1)
output[5] = torch.cat(channels[2],channels[4],1)

criterion:forward(output,targets)
criterion:backward(output,targets)