initialization
initializeFromVcsSerializedPackage: aCGOVcsSerializedPackageAssembly 
	super initializeWithPackageName: aCGOVcsSerializedPackageAssembly name andProject: nil. "will be set later by CGOVcsSerializedProject>>#flushIn:"
	description := aCGOVcsSerializedPackageAssembly description.
	parts := self deserializedDependencies: aCGOVcsSerializedPackageAssembly parts.