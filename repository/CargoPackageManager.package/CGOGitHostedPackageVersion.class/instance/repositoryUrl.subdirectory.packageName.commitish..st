initialization
repositoryUrl: gitUrlString	subdirectory: directoryName	packageName: pkgName commitish: commitOrTag
	repository:= CGOGitRepository 
		repositoryUrl: gitUrlString
		subdirectory: directoryName.
	packageName := pkgName asSymbol.
	commitish := commitOrTag 
