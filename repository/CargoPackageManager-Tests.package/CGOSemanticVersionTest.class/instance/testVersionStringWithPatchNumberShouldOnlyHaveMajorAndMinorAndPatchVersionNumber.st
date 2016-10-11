tests-parsing
testVersionStringWithPatchNumberShouldOnlyHaveMajorAndMinorAndPatchVersionNumber

	self assertVersionFromString: '1.1.3' major: 1 minor: 1 patch: 3 suffix: nil