updating
updateDependenciesOf: aPackageName
	(self ongoingPackageUnitOf: aPackageName) 
		dependencies: ((self imageDependencies at: aPackageName)
			collect: #asPackageDependency
			as: Array)