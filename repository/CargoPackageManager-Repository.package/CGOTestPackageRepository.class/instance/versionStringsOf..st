versions fetching
versionStringsOf: aPackageName
	^ packages 
		detect: [ :package | (package packageName = aPackageName) ]
		ifFound: [ #( '1.0.0' '1.1.5' '2.0.0') ]
		ifNone: [ CGOPackageVersionNotFoundError signal ] 