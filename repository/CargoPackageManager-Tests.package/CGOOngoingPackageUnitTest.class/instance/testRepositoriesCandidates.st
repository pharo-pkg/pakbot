tests-checking
testRepositoriesCandidates
	| candidates |
	candidates := (CGOOngoingPackageUnit on: ManifestCargoPackageManager) repositoriesCandidates.
	self 
		assert: candidates first location
		equals: 'http://smalltalkhub.com/mc/demarey/CargoPackageManager/main/'.
