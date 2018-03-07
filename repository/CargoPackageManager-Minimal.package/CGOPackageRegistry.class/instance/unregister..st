registering
unregister: aPackageVersion
	installedPackages remove: aPackageVersion ifAbsent: [ ^ self ].
	installedPackages 
		detect: [ :packageVersion | packageVersion project = aPackageVersion project ]
		ifNone: [ registeredProjects remove: aPackageVersion project ].