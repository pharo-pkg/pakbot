tests
testWorkingCopy
	| wc |
	wc := (CGOOngoingPackageUnit on: ManifestCargoPackageManager) workingCopy.
	self assert: wc notNil.
	self assert: wc class equals: MCWorkingCopy
