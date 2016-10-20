tests-parsing
testExtractSuffixSuffixedVersionStringShouldReturnSuffix
	
	self 
		assert: (SemanticVersion suffixFrom: '0-RC1')
		equals: '-RC1'