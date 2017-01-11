initialization
repositoryUrl: aStringOrUrl packageName: aString versionString: aVersionString
	repository := CGOMonticelloRepository repositoryUrl: aStringOrUrl.
	packageName := aString asSymbol.
	versionString := aVersionString