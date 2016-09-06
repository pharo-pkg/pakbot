tests
testTopGroups
	| top |
	top := PMPackageDependenciesChecker new 
		buildImageDependencyMap;
		topGroups.
	top inspect
	
	