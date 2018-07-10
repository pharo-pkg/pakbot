printing
printOn: aStream
	aStream 
		<< self class name
		<< '('
		<< self packageName
		<< ')'