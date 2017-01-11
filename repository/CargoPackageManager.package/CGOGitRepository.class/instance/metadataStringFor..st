private
metadataStringFor: aPackageUnit
	^ (STON toStringPretty: aPackageUnit asPackageVersion asSerializablePackageVersion) withInternetLineEndings
