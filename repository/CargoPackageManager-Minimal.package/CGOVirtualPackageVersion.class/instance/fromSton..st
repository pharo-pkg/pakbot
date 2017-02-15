ston
fromSton: stonReader
	super fromSton: stonReader.
	package := CGOPackageProvider default virtualPackageNamed: package.
	version := version asSemanticVersion.