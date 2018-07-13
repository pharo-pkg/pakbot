instance creation
name: projectName repositoryUrl: repositoryString version: versionString
	| projectDependency |
	projectDependency := self basicNew.
	projectDependency initializeWithName: projectName repositoryUrl: repositoryString version: versionString.
	^ projectDependency yourself