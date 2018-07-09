private
registerExternalProjectsOf: aCGOProject
	"Add external projects metadata to this SCM package repository"
	aCGOProject cargoProjectDependencies
		do: [ :projectDependency | 
			self
				registerProjectFromSourceRepository: projectDependency repository
				at: projectDependency name ].
	aCGOProject metacelloProjects
		do:
			[ :cgoMetacelloProject | self registerProject: cgoMetacelloProject at: cgoMetacelloProject name ]