versions fetching
versionStringsOfVirtual: aPackageName
	| package |
	
	package := CGOPackageProvider default virtualPackageNamed: aPackageName.
	^ CGOPackageVersion selectMany: [ :each | each package = package ]