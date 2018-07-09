running
setUp
	fs := FileSystem memory.
	pkgRepository := CGODirectoryPackageRepository basicNew
		instVarNamed: 'rootDirectory' put: fs root;
		yourself