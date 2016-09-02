*CargoPackageManager
packageManifest
	^ [ PackageManifest packageNamed: self ]
		on: NotFound 
		do: [ [  AssemblyManifest  packageNamed: self ]
				on: NotFound
				do: [ NotFound signal: 'Manifest not found for ', self ] ]