local SuperCriterion, parent = torch.class('nn.SuperCriterion', 'nn.Criterion')

--[[
	Fork of nnx.SuperCriterion()
	For original see: 
		https://github.com/clementfarabet/lua---nnx
]]

function SuperCriterion:__init()
   parent.__init(self)
   self.criterions = {}
   self.weights = {}
   self.gradInput = {}
end

function SuperCriterion:add(criterion, weight)
   weight = weight or 1
   table.insert(self.criterions, criterion)
   table.insert(self.weights, weight)
end

function SuperCriterion:updateOutput(input, target)
   self.output = 0
   if type(target) == 'table' then
      for i,criterion in ipairs(self.criterions) do
         self.output = self.output + self.weights[i]*criterion:updateOutput(input[i],target[i])
      end
   else
      for i,criterion in ipairs(self.criterions) do
         self.output = self.output + self.weights[i]*criterion:updateOutput(input[i],target)
      end
   end
   return self.output
end

function SuperCriterion:updateGradInput(input, target)
   if type(target) == 'table' then
      for i,criterion in ipairs(self.criterions) do
         self.gradInput[i] = torch.Tensor() or self.gradInput[i]
         self.gradInput[i]:resizeAs(input[i]):zero()
         --[[
			Need to handle a table of tables of gradients
			so that it works with table criteria like
			nn.CosineHingeEmbeddingCriterion()

			must make self.gradInput a table of tables
			of gradients in the appropriate shape
         ]]
         self.gradInput[i]:add(self.weights[i], criterion:updateGradInput(input[i],target[i]))
      end
   else
      for i,criterion in ipairs(self.criterions) do
         self.gradInput[i] = torch.Tensor() or self.gradInput[i]
         self.gradInput[i]:resizeAs(input[i]):zero()
         self.gradInput[i]:add(self.weights[i], criterion:updateGradInput(input[i],target))
      end
   end
   return self.gradInput
end