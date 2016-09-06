initialization
initializeWithRepository: aPackageRepository
	super initialize.
	packageRepository := aPackageRepository.
	self uriSpace: ZnCallHierarchyRestUriSpace new.
	self uriSpace rootClass: CGORepositoryRestCallHandler