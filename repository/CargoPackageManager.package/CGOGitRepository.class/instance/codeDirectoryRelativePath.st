accessing
codeDirectoryRelativePath
	^ subdirectory ifNotEmpty: [ :subdirectoryName | subdirectoryName , '/' ]