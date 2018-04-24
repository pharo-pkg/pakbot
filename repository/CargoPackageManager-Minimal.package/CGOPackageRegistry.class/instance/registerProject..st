registering
registerProject: aCGOProject
	aCGOProject registry: self.
	(registeredProjects includes: aCGOProject)
		ifFalse: [ self checkProjectRegistrationOf: aCGOProject packageName.
					registeredProjects add: aCGOProject. ].
	^ aCGOProject