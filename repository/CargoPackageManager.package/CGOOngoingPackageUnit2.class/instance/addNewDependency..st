updating - ui
addNewDependency: aWindow
	| package |
	package := SearchFacade rPackageSearch chooseFromOwner: World.
	package ifNotNil: [ self addDependencyOn: package name ]