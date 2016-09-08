builder
buildPackage
	^ [ (CGOOngoingPackageUnit on: self) asPackageVersion ]
		on: CGOWorkingCopyNotFound
		do: [ :ex | ex resume ]