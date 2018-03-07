initialization
initializeFromVcsSerializedPackage: aCGOVcsSerializedPackageUnit
	super initializeWithPackageName: aCGOVcsSerializedPackageUnit name andProject: nil. "will be set later by CGOVcsSerializedProject>>#flushIn:"
	description := aCGOVcsSerializedPackageUnit description.
	dependencies := self deserializedDependencies: aCGOVcsSerializedPackageUnit dependencies.
	provisions:= aCGOVcsSerializedPackageUnit provisions asOrderedCollection.
	platformRequirements := aCGOVcsSerializedPackageUnit platformRequirements asOrderedCollection.