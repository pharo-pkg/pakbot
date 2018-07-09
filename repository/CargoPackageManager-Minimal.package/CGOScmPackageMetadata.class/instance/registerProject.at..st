adding
registerProject: aCGOProject at: projectIdentifier
	"Add external projects metadata to this SCM package repository"
	| packageVersions |
	
	packageVersions := Set new.
	packageVersions add: aCGOProject.
	aCGOProject packageUnits , aCGOProject assemblies, aCGOProject virtualPackages
		do: [ :pkgVersion | packageVersions add: pkgVersion ].
		
	projects
		at: (projectIdentifier ifNil: [ aCGOProject packageName ])
		put: packageVersions.
	self registerExternalProjectsOf: aCGOProject.
	^ aCGOProject