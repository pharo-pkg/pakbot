checking
check: aPackageName
	| ongoing assemblies |
	ongoing := CGOOngoingPackageUnit on: (RPackage named: aPackageName) packageManifest.
	assemblies := self assemblies
		select: [ :assembly | assembly includesAny: (ongoing dependencies collect: #packageName) ]
		thenDo: [ :assembly | self updateDependenciesOf: ongoing with: assembly ]