accessing
dependenciesOf: anOngoingPackageResolution
	"Returns the ongoing package resolution for each dependency of anOngoingPackageResolution"
	^ anOngoingPackageResolution dependencyTargetedPackages
		collect: [ :packageName | 
			ongoingPackageResolutions 
				at: packageName
				ifAbsent: [ self ongoingPackageResolutionForPackageVersion: (alreadyInstalledPackages detect: [ :each | each packageName = packageName ]) ] ]