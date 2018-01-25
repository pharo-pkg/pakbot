adding
registerProjectFromSourceRepository: aCGOSourceRepository
	| project |
	repository := aCGOSourceRepository.
	project := CGOOngoingProject2 fromStonString: aCGOSourceRepository projectMetadataStonString.
	project repository: aCGOSourceRepository.
	packageVersions add: project.
	project packageUnits, project assemblies, project virtualPackages
		do: [ :pkgVersion | packageVersions add: pkgVersion ].
	^ project
