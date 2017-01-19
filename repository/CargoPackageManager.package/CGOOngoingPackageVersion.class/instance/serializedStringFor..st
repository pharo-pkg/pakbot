private
serializedStringFor: aPackageVersion
	^ (STON toStringPretty: aPackageVersion asPackageVersion asSerializablePackageVersion)
		withInternetLineEndings