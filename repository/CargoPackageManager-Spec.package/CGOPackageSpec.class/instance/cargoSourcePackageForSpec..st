compatibility
cargoSourcePackageForSpec: aPackageSpec
	"Package spec defined a list os rouce repositories. It has been replaced by Cargo Source Package Version having an abstraction on the VCS backend and additional data. To avaoid to update all specs, use this method to generate the expecte data."
	^ CGOMonticelloHostedPackageVersion 
		repositoryUrl: aPackageSpec repositories first
		packageName: (aPackageSpec file copyUpToLast: $-)
		versionString: (aPackageSpec file copyAfterLast: $-)