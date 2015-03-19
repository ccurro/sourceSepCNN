dofile('env.lua') -- Import libraries
dofile('criterion.lua')

mixedSignal = getMixture(2)
signalLength = mixedSignal[1]:size(1)

optimState = {
    learningRate = 1,
    learningRateDecay = 0
}

optimMethod = optim.sgd

dofile('model.lua')
dofile('train.lua')