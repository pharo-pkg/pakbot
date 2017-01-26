initialization
initialize
	super initialize.
	projectMetadataFromSCM := CGOScmPackageMetadata new.
	repositories := { projectMetadataFromSCM . self class defaultPackageRepository }.
	packages := OrderedCollection new.
	registry := CGOPackageRegistry default.