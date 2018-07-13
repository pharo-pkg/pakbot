initialization
initializeWithRepository: repositoryString name: projectName version: versionString 
	repository := repositoryString.
	name := projectName.
	version := versionString.
	packageNames := OrderedCollection new.