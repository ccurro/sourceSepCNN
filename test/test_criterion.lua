--[[
	Run this file from root dir of repository with
	dofile('test/test_criterion.lua')
]]


dofile('criterion.lua')

output = {}
channels = {}

for i = 1,4 do
	channels[i] = torch.randn(100)
end

--[[
	channels[1] = Demix 1
	channels[2] = Demix 2
	channels[3] = Mix   1
	channels[4] = Mix   2
]]

output[1] = {channels[1],channels[2]}
output[2] = {channels[1],channels[3]}
output[3] = {channels[1],channels[4]}
output[4] = {channels[2],channels[3]}
output[5] = {channels[2],channels[4]}

criterion:forward(output,targets)
criterion:backward(output,targets)
--[[
	criterion:backward() fails b/c nnx.SuperCriterion() expects
	output[i] to be a tensor and not a table. It is not robust
	to the other table criteria. I suppose that's part of the 
	reason it is in nnx and not nn.

	We may have to fork nnx.SuperCriterion()
]]