--[[
	Work on model skeleton. As in criterion,
	the model should follow this output structure
	for a two channel mix/demix situation:

	Output Table:
		Table 1
			Demix Channel 1
			Demix Channel 2
		Table 2
			Demix Channel 1
			Mix   Channel 1
		Table 3
			Demix Channel 1
			Mix   Channel 2
		Table 4
			Demix Channel 2
			Mix   Channel 1
		Table 5 
			Demix Channel 2
			Mix   Channel 2

	The input to the model should follow this diagram:

	Input Table
		Mix Channel 1
		Mix Channel 2
]]

--[[
	For right now I'm going to construct a model that
	has nn.Select() layers that'll just pass the input
	straight to output so we can test structural details.
]]

model = nn.Sequential()

paths = {}
paths[1] = nn.Sequential()
paths[2] = nn.Sequential()
paths[3] = nn.Sequential()
paths[4] = nn.Sequential()

paths[1]:add(nn.JoinTable(1))
paths[1]:add(nn.Select(1,1)) 
paths[1]:add(nn.View(1,100))
--[[
	nn.Select brings it back down to 1
	channel. Pretend this is MLP

	View goes from Tensor(100) to Tensor(1,100)
	Keeps consistent with other paths
]]

paths[2]:add(nn.JoinTable(1))
paths[2]:add(nn.Select(1,2))
paths[2]:add(nn.View(1,100))
--[[
	nn.Select brings it back down to 1
	channel. Pretend this is MLP

	View goes from Tensor(100) to Tensor(1,100)
	Keeps consistent with other paths
]]

paths[3]:add(nn.SelectTable(1))
paths[3]:add(nn.Identity())


paths[4]:add(nn.SelectTable(2))
paths[4]:add(nn.Identity())

tree = nn.ConcatTable()
tree:add(paths[1])
tree:add(paths[2])
tree:add(paths[3])
tree:add(paths[4])

model:add(tree)

critPaths = {}

critPaths[1] = nn.Sequential()
critPaths[1]:add(nn.ConcatTable():add(nn.SelectTable(1)):add(nn.SelectTable(2)))
critPaths[1]:add(nn.JoinTable(1))

critPaths[2] = nn.Sequential()
critPaths[2]:add(nn.ConcatTable():add(nn.SelectTable(1)):add(nn.SelectTable(3)))
critPaths[2]:add(nn.JoinTable(1))

critPaths[3] = nn.Sequential()
critPaths[3]:add(nn.ConcatTable():add(nn.SelectTable(1)):add(nn.SelectTable(4)))
critPaths[3]:add(nn.JoinTable(1))

critPaths[4] = nn.Sequential()
critPaths[4]:add(nn.ConcatTable():add(nn.SelectTable(2)):add(nn.SelectTable(3)))
critPaths[4]:add(nn.JoinTable(1))

critPaths[5] = nn.Sequential()
critPaths[5]:add(nn.ConcatTable():add(nn.SelectTable(2)):add(nn.SelectTable(4)))
critPaths[5]:add(nn.JoinTable(1))

critTree = nn.ConcatTable()
critTree:add(critPaths[1])
critTree:add(critPaths[2])
critTree:add(critPaths[3])
critTree:add(critPaths[4])
critTree:add(critPaths[5])

model:add(critTree)