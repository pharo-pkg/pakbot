initialization
initializeFromProject: aCGOProject
	super initialize.
	package := aCGOProject package.
	description := aCGOProject description copy.
	units := aCGOProject packageUnits collect: #asOngoingPackageVersion as: Set.
	assemblies := aCGOProject assemblies veryDeepCopy asSet.
	virtualPackages := aCGOProject virtualPackages veryDeepCopy asSet.
	externalProjects := aCGOProject externalProjects veryDeepCopy asSet.