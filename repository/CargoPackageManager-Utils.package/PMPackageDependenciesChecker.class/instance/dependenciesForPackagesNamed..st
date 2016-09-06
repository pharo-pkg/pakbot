compute - dependencies
dependenciesForPackagesNamed: aNameList
	^ ((DAPackageRelationGraph onPackagesNamed: aNameList)
		build;
		packages)
	select: #isSeen