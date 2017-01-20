initialization
initializeFromProject: aCGOProject
	super initialize.
	name := aCGOProject name copy.
	description := aCGOProject description copy.
	repository := aCGOProject repository deepCopy.
	version := aCGOProject version deepCopy.
	unitNames := aCGOProject unitNames asSet.
	assemblies := aCGOProject assemblies deepCopy asSet.
	authors := aCGOProject authors copy asSet.