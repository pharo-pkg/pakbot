fetching
package: aPackageName
	^ (CGOPackage selectOne: [ :each | each name = aPackageName ])
		ifNil: [ CGOPackageNotFoundError signal: 'Cannot find ' , aPackageName ]