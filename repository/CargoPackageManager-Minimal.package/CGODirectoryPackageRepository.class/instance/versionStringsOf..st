versions fetching
versionStringsOf: aPackageName
	"Returns the list of versions available in the repository for the given package name"

	^ [ (self rootDirectory / aPackageName asLowercase) fileNames
			collect: [ :fileName | 
				"Preserve possible upper case letters in the package name"
				aPackageName , CGOPackageVersionReference packageVersionSeparator asString , (fileName copyAfterLast: CGOPackageVersionReference packageVersionSeparator) ] ]
		on: DirectoryDoesNotExist 
		do: [ #() ]