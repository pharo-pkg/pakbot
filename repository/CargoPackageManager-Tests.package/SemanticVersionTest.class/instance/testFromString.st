tests
testFromString
	self should: [ SemanticVersion fromString: 'toto' ] raise: SemanticVersionFormatError.
	self should:  [ SemanticVersion fromString: '1.2.3.4' ] raise: SemanticVersionFormatError.
	self assertVersionFromString: '1.2' major: 1 minor: 2 patch: 0 suffix: nil.
	self assertVersionFromString: '2' major: 2 minor: 0 patch: 0 suffix: nil.
	self assertVersionFromString: '1.1.3' major: 1 minor: 1 patch: 3 suffix: nil.
	self assertVersionFromString: '1.1.3-RC1' major: 1 minor: 1 patch: 3 suffix: '-RC1'.
	self assertVersionFromString: '1.2-dev' major: 1 minor: 2 patch: 0 suffix: '-dev'.