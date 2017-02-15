initialization
initializeCargoRepository
	| cargoDirectory |
	cargoDirectory := fs / 'cargo-repo'.
	self
		writePackageVersions: self cargoPackageVersions , self cargoFakePackageVersions
		to: cargoDirectory.
	self
		writePackageVersions: self cargoVirtualPackageVersions
		to: cargoDirectory  / 'virtual'.
			
	cargoRepository := CGODirectoryPackageRepository basicNew
		instVarNamed: 'rootDirectory' put: cargoDirectory;
		initialize;
		yourself.
	self initializeCargoRepositoryVirtualIndex.