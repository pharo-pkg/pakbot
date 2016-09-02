deserialization
flushIn: aPackageVersion
	"Flush information in this SerializedPackageVersion into the provided PackageVersion.
	All instance variables will be set with values from the SerializedPackageVersion"
	(package isNil or: [ version isNil ])
		ifTrue: [ self error: 'Cannot deserialize a PackageVersion with no package or version defined!' ].	
	aPackageVersion 
		instVarNamed: 'package' put: (CGOPackageProvider default packageNamed: package);
		instVarNamed: 'version' put: (SemanticVersion fromString: version);
		instVarNamed: 'description' put: description;
		instVarNamed: 'timestamp' put: timestamp;
		yourself.
