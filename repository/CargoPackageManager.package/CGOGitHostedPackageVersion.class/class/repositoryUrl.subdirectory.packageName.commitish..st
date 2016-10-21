instance creation
repositoryUrl: gitUrlString	subdirectory: directoryName	packageName: pkgName commitish: commitish
	^ self basicNew 
		repositoryUrl: gitUrlString	subdirectory: directoryName	packageName: pkgName commitish: commitish
		yourself