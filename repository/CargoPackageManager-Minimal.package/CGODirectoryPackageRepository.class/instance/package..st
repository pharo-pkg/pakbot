fetching
package: aPackageName
	(self rootDirectory / aPackageName asLowercase) exists 
		ifFalse: [ CGOPackageNotFoundError signal: 'Cannot find ' , aPackageName , ' package' ]