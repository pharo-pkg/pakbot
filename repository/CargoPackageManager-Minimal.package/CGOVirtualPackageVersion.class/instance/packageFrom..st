initialization - private
packageFrom: aDictionary
	| aSymbol |
	aSymbol := self mandatoryKey: #package from: aDictionary.
	aSymbol isSymbol
		ifFalse: [ CGOPackageVersionInitializationError signal: 'The package value must be a Symbol' ].
	^ CGOPackageProvider default virtualPackageNamed: aSymbol