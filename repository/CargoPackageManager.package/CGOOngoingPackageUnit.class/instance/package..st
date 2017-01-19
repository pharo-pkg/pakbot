updating
package: aPackageName
	aPackageName isSymbol
		ifFalse: [ CGOPackageVersionInitializationError signal: 'The package value must be a Symbol' ].
	package := CGOPackageProvider default packageNamed: aPackageName