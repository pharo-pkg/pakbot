tests-parsing
testVersionStringWithMinorNumberShouldOnlyHaveMajorAndMinorVersionNumber

	self assertVersionFromString: '1.2' major: 1 minor: 2 patch: 0 suffix: nil