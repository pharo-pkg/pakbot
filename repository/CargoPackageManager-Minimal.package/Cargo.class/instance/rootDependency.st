private
rootDependency
	| pkgVersionRef |
	pkgVersionRef := packages first.
	^ CGOPackageDependency 
		on: pkgVersionRef packageName
		for: nil 
		withConstraints: (pkgVersionRef versionNumber
			ifEmpty: [ #() ]
			ifNotEmpty: [ {(CGOFixedVersionConstraint with: pkgVersionRef versionNumber)} ] ) 