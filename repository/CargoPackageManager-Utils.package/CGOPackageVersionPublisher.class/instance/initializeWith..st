initialization
initializeWith: aCGODirectoryPackageRepository 
	pkgRepository := aCGODirectoryPackageRepository.
	manifests := Set new.
	shouldPublishDependencies := false.
	visited := Set new