versions fetching
packages
	"list name of all packages available in the repository"

	^ self rootDirectory directoryNames
		reject: [ :each | each = 'virtual' ]