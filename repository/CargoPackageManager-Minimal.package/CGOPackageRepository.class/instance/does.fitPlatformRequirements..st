private
does: aPackageVersion fitPlatformRequirements: requirements
	^ aPackageVersion platformRequirements 
			ifEmpty: [ true ]
			ifNotEmpty: [ :pkgRequirements | (requirements asSet intersection: pkgRequirements asSet) notEmpty ]