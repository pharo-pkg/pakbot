adding
registerProjectFromSourceRepository: aCGOSourceRepository
	| project |
	repository := aCGOSourceRepository.
	project := CGOOngoingProject fromStonString: aCGOSourceRepository projectMetadataStonString.
	project repository: aCGOSourceRepository.
	packageVersions add: project.
	project packageUnits, project assemblies, project virtualPackages
		do: [ :pkgVersion | packageVersions add: pkgVersion ].
	"Add external projects metadata to this SCM package repository"
	project externalProjects 
		do: [ :externalProject | self registerProjectFromSourceRepository: externalProject repository ].
	^ project
