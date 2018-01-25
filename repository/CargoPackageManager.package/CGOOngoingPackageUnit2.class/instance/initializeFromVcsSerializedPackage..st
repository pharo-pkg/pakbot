initialization
initializeFromVcsSerializedPackage: aCGOVcsSerializedPackageUnit
	super initializeWithPackageName: aCGOVcsSerializedPackageUnit name andProject: nil. "will be set later"
	description := aCGOVcsSerializedPackageUnit description.
	self deserializeDependencies: aCGOVcsSerializedPackageUnit dependencies.
	provisions:= aCGOVcsSerializedPackageUnit provisions asOrderedCollection.
	platformRequirements := aCGOVcsSerializedPackageUnit platformRequirements asOrderedCollection.