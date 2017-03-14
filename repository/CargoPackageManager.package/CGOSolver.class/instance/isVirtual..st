private
isVirtual: aPackageName
	repositories do: 
		[ :repository | 
			[ ^ repository isVirtual: aPackageName ] 
			on: CGOPackageNotFoundError
			do: [ "ignore" ] ].
	CGOPackageNotFoundError signal: aPackageName