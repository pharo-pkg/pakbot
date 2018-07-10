instance creation
configuration: configurationName repositoryUrl: repositoryString version: versionString
	| projectDependency |
	projectDependency := self basicNew.
	projectDependency initializeWithName: configurationName repositoryUrl: repositoryString version: versionString.
	^ projectDependency yourself