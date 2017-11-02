initialization
initializeWithProjectName: aProjectName
	super initialize.
	name := aProjectName asSymbol.
	unitNames := Set new.
	assemblies := Set new.
	virtualPackages := Set new.