initialization
writePackageVersions: aListOfPackageVersions to: aFolder
	aListOfPackageVersions
		do: [ :pkgVersion |
			(aFolder / pkgVersion packageName asLowercase) ensureCreateDirectory.
			aFolder / pkgVersion packageName asLowercase / pkgVersion name asLowercase
				writeStreamDo: [ :stream | stream nextPutAll: (CGOPackageVersionWriter toStringPretty: pkgVersion) ] ].