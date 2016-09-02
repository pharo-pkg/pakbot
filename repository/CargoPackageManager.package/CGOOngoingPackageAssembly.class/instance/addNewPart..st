updating - ui
addNewPart: aWindow
	| package |
	package := SearchFacade rPackageSearch chooseFromOwner: World.
	self flag: 'TODO: add the list of assemblyManifest to the search'.
	package ifNotNil: [ self addPartOn: package name ]