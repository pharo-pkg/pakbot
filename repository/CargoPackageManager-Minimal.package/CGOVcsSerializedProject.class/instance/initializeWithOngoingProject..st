initialization
initializeWithOngoingProject: aCGOOngoingProject
	super initializeWithOngoingPackageUnit: aCGOOngoingProject.
	units := self toArrayOrNilIfEmpty: (aCGOOngoingProject packageUnits collect: #asVcsSerializedPackageUnit).
	assemblies := self toArrayOrNilIfEmpty: aCGOOngoingProject assemblies "asSerializableAssembly?".
	virtualPackages := self toArrayOrNilIfEmpty: (aCGOOngoingProject virtualPackages collect: #asVcsSerializablePackageVersion).
