printing
printOn: aStream
	aStream
		<< self class name
		<< '('
		<< self resolvedProjectVersion asString
		<< ')'