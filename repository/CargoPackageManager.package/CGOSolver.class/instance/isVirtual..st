private
isVirtual: aPackageName
	repositories do: 
		[ :repository | 
			[ repository package: aPackageName.
			^ false "package found!" ] 
			on: CGOPackageNotFoundError
			do: [ "ignore" ] ].
	^ true "no package found!"