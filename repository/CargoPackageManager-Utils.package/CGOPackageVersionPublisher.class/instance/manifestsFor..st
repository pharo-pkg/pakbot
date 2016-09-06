private
manifestsFor: aListOfPackageNames 
	^ aListOfPackageNames 
		collect: [ :pkgName | self manifestFor: pkgName ]
