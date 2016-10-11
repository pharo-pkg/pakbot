tests-parsing
testVersionStringWithMajorNumberShouldOnlyHaveMajorVersionNumber

	self assertVersionFromString: '2' major: 2 minor: 0 patch: 0 suffix: nil