helpers
stonSerializationFor: aString
	^ CGOPackageVersionWriter toStringPretty: (SemanticVersion fromString: aString)