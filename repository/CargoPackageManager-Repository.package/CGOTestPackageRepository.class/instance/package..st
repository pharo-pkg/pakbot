fetching
package: aString 
	^ (packages
		detect: [ :pkgVersion | pkgVersion packageName = aString ]
		ifNone: [ CGOPackageNotFoundError signal: 'Cannot find package ' , aString ]) package