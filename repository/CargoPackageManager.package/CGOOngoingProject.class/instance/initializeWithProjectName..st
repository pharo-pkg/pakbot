initialization
initializeWithProjectName: aProjectName
	super initialize.
	name := aProjectName asSymbol.
	version := '0.1-dev' asSemanticVersion. "default version number"
	unitNames := Set new.
	assemblies := Set new.
	authors := Set new:0.