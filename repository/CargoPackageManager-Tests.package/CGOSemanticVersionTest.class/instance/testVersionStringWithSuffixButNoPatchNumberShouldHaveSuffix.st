tests-parsing
testVersionStringWithSuffixButNoPatchNumberShouldHaveSuffix

	self assertVersionFromString: '1.1-RC1' major: 1 minor: 1 patch: 0 suffix: '-RC1'