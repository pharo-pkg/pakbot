versions fetching
versionStringsOf: aPackageName
	"Returns the list of versions available in the repository for the given package name"

	^ [ (self rootDirectory / aPackageName asLowercase) fileNames ]
		on: DirectoryDoesNotExist 
		do: [ #() ]