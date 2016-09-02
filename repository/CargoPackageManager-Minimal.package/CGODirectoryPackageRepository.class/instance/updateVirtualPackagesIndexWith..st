versions posting
updateVirtualPackagesIndexWith: aPackageVersion
	aPackageVersion isAssembly ifTrue: [ ^ self ].
	aPackageVersion provisions
		ifEmpty: [ ^ self ]
		ifNotEmpty: [ :provisions | 
			provisions
				do: [ :provision | 
					| file |
					file := (self virtualDirectory / provision asLowercase)
						ensureCreateFile.
					file
						writeStreamDo: [ :stream | 
							stream
								setToEnd;
								nextPutAll: aPackageVersion name;
								cr ] ] ]