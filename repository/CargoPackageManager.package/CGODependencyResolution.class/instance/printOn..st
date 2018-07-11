printing
printOn: aStream
	aStream 
		<< self class name;
		<< '(';
		<< rootDependency printString;
		<< '=>';
		<< ongoingPackageResolutions printString;
		<< ')'