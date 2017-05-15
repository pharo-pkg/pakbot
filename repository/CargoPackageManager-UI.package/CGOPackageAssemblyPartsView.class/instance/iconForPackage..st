private
iconForPackage: part
	^ (ongoingPackageVersion project unitNames includes: part targetedPackage)
		ifTrue: [ self unitPartIcon ]
		ifFalse: [ self assemblyPartIcon ]