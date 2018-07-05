tests
testGroupCandidates
	| candidates |
	candidates := PMPackageDependenciesChecker new 
		buildImageDependencyMap;
		groupCandidates.
	candidates inspect
	
	