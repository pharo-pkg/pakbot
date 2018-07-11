printing
printOn: aStream
	aStream
		<< self class name
		<< '('
		<< name
		<< '::'
		<< packageVersions asString
		<< ')'