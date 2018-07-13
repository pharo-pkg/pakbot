instance-creation
fromMetacelloSpec: aMetacelloSpec 
	^ self
		name: aMetacelloSpec name
		repositoryUrl: aMetacelloSpec repositories map values first description
		version: aMetacelloSpec versionString