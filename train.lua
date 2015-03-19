----------------------------------------------------------------------
print '==> train.lua'

model:training()

parameters,gradParameters = model:getParameters()

print '==> defining training procedure'
function train()
   local time = sys.clock()
   print('<trainer> on training set:')

for t = 1,1e5 do
      -- create closure to evaluate f(X) and df/dX
      local feval = function(x)
        -- get new parameters
        if x ~= parameters then
           parameters:copy(x)
        end
        gradParameters:zero()
        local f = 0;
        local oHat = model:forward(mixedSignal)
        f = f + criterion:forward(oHat,targets)
        model:backward(mixedSignal,criterion:backward(oHat,targets)) --problem line            
        print('# of Examples:',t,'Error:',f)
        return f,gradParameters
      end
      optimMethod(feval, parameters, optimState)
      collectgarbage()
   end
   -- time taken
time = sys.clock() - time
print("<trainer> time for 1 Epoch = " .. (time) .. 's')
end

train()
