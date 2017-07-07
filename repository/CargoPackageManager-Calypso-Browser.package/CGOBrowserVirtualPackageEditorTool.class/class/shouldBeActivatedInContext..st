accessing
shouldBeActivatedInContext: aBrowserContext
	^ aBrowserContext isPackageGroupSelected and: [ aBrowserContext lastSelectedPackageGroup isKindOf: CGOClyVirtualPackage  ]