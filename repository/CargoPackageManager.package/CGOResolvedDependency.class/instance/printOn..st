printing
printOn: aStream

	aStream
		<< self class name
		<< '('
		<< dependency asString
		<< ' => '
		<< resolution asString
		<< ')'