compatibility - cargo solver
asPackageVersionReference
	"Needed so that Cargo solver can use a project as a standard package assembly"
	^ CGOPackageVersionReference new
		initializeWithName: name version: version asString;
		yourself