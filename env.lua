require 'nn'
require 'cutorch'
require 'cunn'
-- require 'nnx'
--[[
	Disabled nnx while we work on a fork of 
	nnx.SuperCriterion() due to it's limitations
	working with table criteria.
]]
require 'audio'
require 'signal'
require 'gnuplot'
require('sampleGen/randMixture.lua')
require('SuperCriterion.lua')