building
packageListIn: aPresentation
	^ aPresentation tree
		title: 'Package Manifest List';
		icon: [ Smalltalk ui icons packageIcon ];
		display: [ :items | items sorted: [ :a :b | a name < b name ]  ];
		format: [ :item | | packageManifestName |
					packageManifestName := item name.
					(packageManifestName beginsWith: self manifestClassPrefix)
						ifTrue: [ packageManifestName 
										copyFrom: self manifestClassPrefix size + 1
										to: packageManifestName size ]
						ifFalse: [ packageManifestName ] ];
		act: [ :presentation :manifest | self newPackageVersion ]
		icon: GLMUIThemeExtraIcons glamorousAdd
		entitled: 'Create a new package version'