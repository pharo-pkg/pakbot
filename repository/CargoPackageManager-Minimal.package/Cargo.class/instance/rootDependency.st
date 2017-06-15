private
rootDependency
	| pkgVersionRef |
	pkgVersionRef := packages first.
	^ CGOPackageDependency 
		on: pkgVersionRef packageName
		for: nil 
		withConstraints: (pkgVersionRef versionString
			ifEmpty: [ #() ]
			ifNotEmpty: [ {(CGOFixedVersionConstraint with: pkgVersionRef versionString)} ] ) 