initialization
initializeWithProjectName: aProjectName
	self initializeWithPackageName: aProjectName andProject: nil.
	units := Set new.
	assemblies := Set new.
	virtualPackages := Set new.
	externalProjects := Set new.