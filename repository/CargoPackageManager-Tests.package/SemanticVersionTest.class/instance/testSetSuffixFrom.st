tests
testSetSuffixFrom
	self 
		assert: (SemanticVersion suffixFrom: '0-RC1')
		equals: '-RC1'