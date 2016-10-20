tests-parsing
testVersionStringWithSuffixButNoMinorNorPatchNumberShouldHaveSuffix

	self assertVersionFromString: '1-RC1' major: 1 minor: 0 patch: 0 suffix: '-RC1'