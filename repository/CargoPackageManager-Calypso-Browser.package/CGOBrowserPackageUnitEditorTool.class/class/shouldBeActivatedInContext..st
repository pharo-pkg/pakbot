accessing
shouldBeActivatedInContext: aBrowserContext
	^ aBrowserContext isPackageSelected and: [ aBrowserContext lastSelectedPackage isKindOf: ClyManagedPackage   ]