updating
addPart: aPackageNameOraPackageVersionReference 
	| pkgVersionRef constraints |
	pkgVersionRef := aPackageNameOraPackageVersionReference asPackageVersionReference.
	constraints := pkgVersionRef versionNumber 
		ifNil: [ #() ]
		ifNotNil: [ Array with: '=' , pkgVersionRef versionString ].
	parts add: (CGOPackageDependency newFrom: pkgVersionRef packageName  -> constraints)