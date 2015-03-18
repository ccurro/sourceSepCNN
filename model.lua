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
	has nn.Identity() layers that'll just pass the input
	straight to output so we can test structural details.
]]
