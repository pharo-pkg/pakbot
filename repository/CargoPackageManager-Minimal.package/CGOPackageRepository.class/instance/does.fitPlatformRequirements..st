private
does: aPackageVersion fitPlatformRequirements: requirements
	^ aPackageVersion platformRequirements 
			ifEmpty: [ true ]
			ifNotEmpty: [ :pkgRequirements | (requirements asSet intersect: pkgRequirements asSet) notEmpty ]