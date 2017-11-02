initialization
initializeFromProject: aCGOProject
	super initialize.
	name := aCGOProject packageName copy.
	description := aCGOProject description copy.
	unitNames := aCGOProject unitNames asSet.
	assemblies := aCGOProject assemblies veryDeepCopy asSet.
	virtualPackages := aCGOProject virtualPackages veryDeepCopy asSet.