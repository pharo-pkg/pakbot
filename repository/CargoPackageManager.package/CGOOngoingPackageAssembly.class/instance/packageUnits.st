accessing
packageUnits
	"Will follow assembly parts to collect transitively its parts as package units"
	| units |
	
	units := Set new.
	manifest parts 
		collect: #key
		thenDo: [ :pkgName |
			AssemblyManifest allSubclasses 
				detect: [ :each | each packageName = pkgName]
				ifFound: [ :assemblyManifest | units addAll: (CGOOngoingPackageAssembly on: assemblyManifest) packageUnits ]
				ifNone: [ units add: pkgName ]
 		].
	^ units asSortedCollection