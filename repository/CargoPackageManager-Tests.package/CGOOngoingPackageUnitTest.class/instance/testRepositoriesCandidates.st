tests-checking
testRepositoriesCandidates
	| candidates |
	candidates := (CGOOngoingPackageUnit on: ManifestCargoPackageManager) repositoriesCandidates.
	self 
		assert: candidates first location
		equals: 'github://demarey/cargo:master/repository'.
