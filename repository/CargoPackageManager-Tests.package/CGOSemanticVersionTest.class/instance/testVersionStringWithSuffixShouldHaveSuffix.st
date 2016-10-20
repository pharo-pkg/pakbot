tests-parsing
testVersionStringWithSuffixShouldHaveSuffix

	self assertVersionFromString: '1.1.3-RC1' major: 1 minor: 1 patch: 3 suffix: '-RC1'