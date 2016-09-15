printing
printOn: aStream
	aStream 
		<< 'a CGODependencyResolution for ';
		<< rootDependency printString;
		cr;
		<< ongoingPackageResolutions printString 