private
manifestFor: aPackageName 
	^ [ PackageManifest packageNamed: aPackageName ]
		on: NotFound 
		do: [ [ AssemblyManifest packageNamed: aPackageName ]
				on: NotFound 
				do: [ NotFound signalFor: aPackageName ] ]