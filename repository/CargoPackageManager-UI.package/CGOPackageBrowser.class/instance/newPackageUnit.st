actions
newPackageUnit
	| package |
	package := SearchFacade rPackageSearch chooseFromOwner: World.
	^ package 
		ifNil: [ nil ]
		ifNotNil: [ | manifest |
				manifest := TheManifestBuilder new createManifestNamed: package name.
				(CGOOngoingPackageVersion on: manifest new)
					updatePackageName: package name.
				manifest  ]