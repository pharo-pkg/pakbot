tests
mailVirtualPackage
	| virtualPkgVersion |
	virtualPkgVersion := CGOVirtualPackageVersion example.
	virtualPkgVersion
		instVarNamed: 'timestamp'
		put: (STON fromString: 'DateAndTime [ ''2017-02-03T11:11:15.370245+01:00'' ]').
	^ virtualPkgVersion