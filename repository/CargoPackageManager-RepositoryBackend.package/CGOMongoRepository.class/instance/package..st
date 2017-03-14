fetching
package: aPackageName
	^ (CGOPackage selectOne: [ :each | each name = aPackageName ])
		ifNil: [ CGOPackageNotFoundError signal: aPackageName ]