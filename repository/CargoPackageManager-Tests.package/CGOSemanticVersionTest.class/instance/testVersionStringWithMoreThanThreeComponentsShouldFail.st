tests-parsing
testVersionStringWithMoreThanThreeComponentsShouldFail

	self should:  [ SemanticVersion fromString: '1.2.3.4' ] raise: SemanticVersionFormatError