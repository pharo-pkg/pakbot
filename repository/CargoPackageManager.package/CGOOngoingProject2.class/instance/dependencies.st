accessing
dependencies
	"Needed so that Cargo solver can use a project as a standard package assembly"
	^ self packageUnitNames collect: #asPackageDependency