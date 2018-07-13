adding
registerProjectFromSourceRepository: aCGOMetacelloProjectRepository
	| project |
	project := PBMetacelloProject fromRepository: aCGOMetacelloProjectRepository.
	packageVersions add: project.
	^ project
