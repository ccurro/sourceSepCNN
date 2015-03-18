
--[[
	For a 2 channel mixture the expected output for the neural
	network is a table with 5 entries. Each entry in the table
	is a table itself. Follow this diagram:

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
			Mix   Channel 1

	We have a different objective to maximize for each table.
	We may want to set weights for each and determine if any of
	them are more important than the others. Follow this diagram:

	Output Table:
		Table 1 - Dissimilarity 
		Table 1 - Similarity 		
		Table 1 - Similarity 		
		Table 1 - Similarity 
		Table 1 - Similarity 		
]]

criterion == nn.SuperCriterion()
-- ^ Can input weights to determine how objectives are combined.
-- For now we'll start with 5 equally weighted cosine similarities
criterion:add(nn.CosineEmbeddingCriterion())
criterion:add(nn.CosineEmbeddingCriterion())
criterion:add(nn.CosineEmbeddingCriterion())
criterion:add(nn.CosineEmbeddingCriterion())
criterion:add(nn.CosineEmbeddingCriterion())

-- For this criterion our targets are constant across all inputs
-- The sign of the 1 corresponds to dissimilarity/similarity.
targets = {-1,1,1,1,1}
