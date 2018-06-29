adding
registerProjectFromSourceRepository: aCGOMetacelloProjectRepository
	| project |
	project := CGOMetacelloProject fromRepository: aCGOMetacelloProjectRepository.
	packageVersions add: project.
	^ project
