versions posting
updateVirtualPackagesIndexWith: aPackageVersion
	aPackageVersion isAssembly ifTrue: [ ^ self ].
	aPackageVersion provisions
		ifEmpty: [ ^ self ]
		ifNotEmpty: [ :provisions | 
			provisions 
				do: [ :virtualPackageVersionRef | | dir file |
					dir := (self virtualIndexesDirectory / virtualPackageVersionRef packageName asLowercase) ensureCreateDirectory.
					file :=  (dir / virtualPackageVersionRef asString asLowercase) ensureCreateFile.
					file
						writeStreamDo: [ :stream | 
							stream
								setToEnd;
								nextPutAll: aPackageVersion name;
								cr ] ] ]