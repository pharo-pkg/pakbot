initialization
initializeWithOngoing: aCGOOngoingProject
	super initializeWithOngoing: aCGOOngoingProject.
	units := self toArrayOrNilIfEmpty: (aCGOOngoingProject packageUnits collect: #asVcsSerializedPackageUnit).
	assemblies := self toArrayOrNilIfEmpty: (aCGOOngoingProject assemblies collect: #asVcsSerializedPackageAssembly).
	virtualPackages := self toArrayOrNilIfEmpty: (aCGOOngoingProject virtualPackages collect: #asVcsSerializablePackageVersion).
	externalProjects := self toArrayOrNilIfEmpty: (aCGOOngoingProject externalProjects)
