accessing
codeDirectoryRelativePath
	^ self subdirectory ifNotEmpty: [ :subdirectoryName | subdirectoryName , '/' ]