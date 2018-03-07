registering
registerProject: aCGOProject
	aCGOProject registry: self.
	(registeredProjects includes: aCGOProject)
		ifFalse: [ self checkProjectRegistrationOf: aCGOProject name.
					registeredProjects add: aCGOProject. ].
	^ aCGOProject