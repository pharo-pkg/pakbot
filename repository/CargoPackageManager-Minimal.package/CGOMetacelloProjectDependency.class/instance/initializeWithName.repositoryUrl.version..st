initialization
initializeWithName: projectName repositoryUrl: urlOrString version: aVersionString 
	name := projectName asSymbol.
	url := urlOrString asZnUrl.
	version := aVersionString.
	