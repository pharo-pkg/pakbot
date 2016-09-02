private
isVirtual: aPackageName
	[ self package: aPackageName.
	^ false "package found!" ] 
		on: CGOPackageNotFoundError
		do: [ "ignore" ].
	^ true "no package found!"