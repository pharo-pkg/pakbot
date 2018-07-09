private - displaying
iconForPackage: part

	^ self unitIcon
	"^ (ongoingPackageVersion project packageUnitNames includes: part targetedPackage)
		ifTrue: [ self unitIcon ]
		ifFalse: [ (ongoingPackageVersion project virtualPackages anySatisfy: [ :virtual | virtual packageName = part targetedPackage ])
			ifTrue: [ self virtualPackageIcon ]
			ifFalse: [ self assemblyIcon ] ]"