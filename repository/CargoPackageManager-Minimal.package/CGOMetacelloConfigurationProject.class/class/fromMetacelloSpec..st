instance-creation
fromMetacelloSpec: aMetacelloSpec

	^ self
		configuration: aMetacelloSpec name
		repositoryUrl: aMetacelloSpec repositories map values first description
		version: aMetacelloSpec versionString