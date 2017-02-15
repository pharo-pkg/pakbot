versions fetching
versionStringsOfVirtual: aVirtualPackageName
	"Returns the list of versions available in the repository for the given package name"

	^ [ (self virtualDirectory / aVirtualPackageName asLowercase) fileNames ]
		on: DirectoryDoesNotExist 
		do: [ #() ]