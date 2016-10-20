versions fetching
packageNames
	"list name of all packages available in the repository"

	^ self rootDirectory directoryNames
		reject: [ :each | each = 'virtual' ]