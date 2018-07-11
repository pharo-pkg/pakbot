protocol
resolvedPackageFor: aDependency
	| ongoingPackageResolution packageVersionRef |
	
	ongoingPackageResolution := resolution ongoingPackageResolutionFor: aDependency name.
	packageVersionRef := aDependency resolveInSolver: self.
	"packageVersionRef := (self isVirtual: aDependency name)
		ifTrue: [ | pkgVersionString | 
				pkgVersionString := self solveVirtualPackageDependency: aDependency.
				CGOPackageVersionReference newOn: pkgVersionString ]
		ifFalse: 
			[ CGOPackageVersionReference new
				initializeWithName: aDependency name
				version: (self versionFor: aDependency name) asString;
				yourself ]".
			
	"packageVersionRef packageRepositories: repositories."
	ongoingPackageResolution resolution: packageVersionRef.
	^ ongoingPackageResolution