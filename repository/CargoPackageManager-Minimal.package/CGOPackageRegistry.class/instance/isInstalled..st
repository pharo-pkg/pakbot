quering
isInstalled: aPackageDependency 
	
	^ installedPackages anySatisfy: [ :each | aPackageDependency isProvidedBy: each  ]