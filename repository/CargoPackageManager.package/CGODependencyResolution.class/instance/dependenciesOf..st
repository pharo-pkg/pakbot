accessing
dependenciesOf: anOngoingPackageResolution
	"Returns the ongoing package resolution for each dependency of anOngoingPackageResolution"
	^ anOngoingPackageResolution dependencyTargetedPackages
		collect: [ :package | ongoingPackageResolutions at: package ]