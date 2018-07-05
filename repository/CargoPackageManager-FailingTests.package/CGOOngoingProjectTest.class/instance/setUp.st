initialization
setUp
	super setUp.
	defaultPackageRepository := Cargo defaultPackageRepository.
	fs := FileSystem memory.
	testPackageRepository := CGODirectoryPackageRepository basicNew
		instVarNamed: 'rootDirectory' put: fs root;
		yourself.
	Cargo defaultPackageRepository: testPackageRepository