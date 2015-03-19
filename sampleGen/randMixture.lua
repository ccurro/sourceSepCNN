function getMixture(n)
	-- getMixture(n) -> Get an n channel random linear mix
	-- Maxmimum n is 10
	assert(n < 11 and (n % 1 == 0),'n must be an integer less than 10')
	local fs = 44.1e3 -- Sample Rate
	local duration = 0.1 -- Length of Mixture in time
	local t = torch.linspace(0,duration,duration*fs) -- Generate time index
	local x = {}
	-- local x = torch.Tensor(2,duration*fs)
	f = torch.randperm(10):mul(1e3) --[[
		generate random frequenies on discrete set of
		{1e3..1e4} increment by 1e3
	]] 
	for i = 1,n do
		w = 2*math.pi*f[1] -- These are nums not Tensors, so I can use *
		x[i] = torch.sin(t:mul(w))
	end
	return x
end