initialization
initializeWithName: configurationName repositoryUrl: urlOrString version: aVersionString 
	configuration := configurationName asSymbol.
	url := urlOrString asZnUrl.
	version := aVersionString.
	