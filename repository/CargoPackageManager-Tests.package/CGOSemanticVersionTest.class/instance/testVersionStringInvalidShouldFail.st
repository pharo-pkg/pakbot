tests-parsing
testVersionStringInvalidShouldFail

	self should: [ SemanticVersion fromString: 'toto' ] raise: SemanticVersionFormatError