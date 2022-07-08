"
I hold load instructions and source packages for Grease.
"
Class {
	#name : #GreaseTestResource,
	#superclass : #TestResource,
	#instVars : [
		'fs',
		'mcRepository',
		'versionReferences',
		'cargoRepository'
	],
	#category : #'CargoPackageManager-TestRessources-Resources'
}

{ #category : #'data - cargo package versions' }
GreaseTestResource >> cargoFakePackageVersions [
	"fake package versions"
	^ #( 'GoferBar@1-branch-lr'
		'GoferBar@2-branch-lr'
		'GoferBar@1'
		'GoferBar@1.1'
		'GoferBar@2'
		'GoferBar@4'
		'Grease-Core@1.1.12'
	) collect: [ :each |
		 CGOPackageUnit fromString: each ].

]

{ #category : #accessing }
GreaseTestResource >> cargoLocalRepository [
	^ cargoRepository 
]

{ #category : #'data - cargo package versions' }
GreaseTestResource >> cargoPackageVersions [
	^ self class methods 
		select: [ :each | each hasPragmaNamed: #cargoPackageVersion ]
		thenCollect: [ :method | self withArgs: #() executeMethod: method ]
]

{ #category : #'data - cargo package versions' }
GreaseTestResource >> cargoVirtualPackageVersions [
	^ #('Grease-Core-Platform@1' 'Grease-Slime@0.1' 'Grease-Slime@1')
		collect: [ :provision | CGOVirtualPackageVersion fromString: provision ]
]

{ #category : #'data - cargo package versions' }
GreaseTestResource >> greasecore1_1_13 [
	<cargoPackageVersion>
	^ STON fromString: 
'CGOPackageUnit {
	#package : #Grease-Core,
	#description : ''Core package of the Grease library.'',
	#version : ''1.1.13'',
	#timestamp : DateAndTime [ ''2015-04-14T14:51:50.116+00:00'' ],
	#dependencies : [ ],
	#src: CGOMonticelloHostedPackageVersion {
		#repository : CGOMonticelloRepository {
			#repositoryUrl : ''http://smalltalkhub.com/mc/Seaside/Grease11/main/''
		},
		#packageName : #Grease-Core,
		#versionString : ''JohanBrichau.94''
	}
}'
]

{ #category : #'data - cargo package versions' }
GreaseTestResource >> greasecore1_1_13devWithDescription: aDescription [
	^ STON fromString: 
('CGOPackageUnit {
	#package : #Grease-Core,
	#description : ''', aDescription,''',
	#version : ''1.1.13-dev'',
	#timestamp : DateAndTime [ ''2015-04-14T14:51:50.116+00:00'' ],
	#dependencies : [ ],
	#src: CGOMonticelloHostedPackageVersion {
		#repository : CGOMonticelloRepository {
			#repositoryUrl : ''http://smalltalkhub.com/mc/Seaside/Grease11/main/''
		},
		#packageName : #Grease-Core,
		#versionString : ''JohanBrichau.94''
	}
}') 
]

{ #category : #'data - cargo package versions' }
GreaseTestResource >> greasepharo30core1_1_13 [
	<cargoPackageVersion>
	^ STON fromString: 
'CGOPackageUnit {
	#package : #Grease-Pharo30-Core,
	#description : ''Platform-specific package of the Grease-Core package for Pharo.'',
	#version : ''1.1.13'',
	#timestamp : DateAndTime [ ''2015-05-11T14:56:14.307+00:00'' ],
	#dependencies : [
		#Grease-Core : [ ]
	],
	#src: CGOMonticelloHostedPackageVersion {
		#repository : CGOMonticelloRepository {
			#repositoryUrl : ''http://smalltalkhub.com/mc/Seaside/Grease11/main/''
		},
		#packageName : #Grease-Pharo30-Core,
		#versionString : ''JohanBrichau.16''
	},
	#platformRequirements : [
		''pharo''
	],
	#provisions : [
		''Grease-Core-Platform''
	]
}'
]

{ #category : #'data - cargo package versions' }
GreaseTestResource >> greasepharo30slime1_1_13 [
	<cargoPackageVersion>
	^ STON fromString: 
'CGOPackageUnit {
	#package : #Grease-Pharo30-Slime,
	#description : ''Slime uses the Refactoring Browser to find and, in some cases, rewrite common compatibility problems.'',
	#version : ''1.1.13'',
	#timestamp : DateAndTime [ ''2015-05-11T14:57:11.795+00:00'' ],
	#dependencies : [
		#Grease-Core-Platform : [ ]
	],
	#src: CGOMonticelloHostedPackageVersion {
		#repository : CGOMonticelloRepository {
			#repositoryUrl : ''http://smalltalkhub.com/mc/Seaside/Grease11/main/''
		},
		#packageName : #Grease-Slime,
		#versionString : ''pmm.29''
	},
	#platformRequirements : [
		''pharo3.x''
	],
	#provisions : [
		''Grease-Slime''
	]
}'
]

{ #category : #'data - cargo package versions' }
GreaseTestResource >> greasepharo40slime1_1_13 [
	<cargoPackageVersion>
	^ STON fromString: 
'CGOPackageUnit {
	#package : #Grease-Pharo40-Slime,
	#description : ''Slime uses the Refactoring Browser to find and, in some cases, rewrite common compatibility problems.'',
	#version : ''1.1.13'',
	#timestamp : DateAndTime [ ''2015-05-11T14:56:09.456+00:00'' ],
	#dependencies : [
		#Grease-Core-Platform : [ ]
	],
	#src: CGOMonticelloHostedPackageVersion {
		#repository : CGOMonticelloRepository {
			#repositoryUrl : ''http://smalltalkhub.com/mc/Seaside/Grease11/main/''
		},
		#packageName : #Grease-Pharo40-Slime,
		#versionString : ''JohanBrichau.3''
	},
	#platformRequirements : [
		''pharo5.x''
	],
	#provisions : [
		''Grease-Slime''
	]
}'
]

{ #category : #initialization }
GreaseTestResource >> initialize [
	super initialize.
	fs := FileSystem memory.
	self initializeCargoRepository
]

{ #category : #initialization }
GreaseTestResource >> initializeCargoRepository [
	| cargoDirectory |
	cargoDirectory := fs / 'cargo-repo'.
	self
		writePackageVersions: self cargoPackageVersions , self cargoFakePackageVersions
		to: cargoDirectory.
	self
		writePackageVersions: self cargoVirtualPackageVersions
		to: cargoDirectory  / 'virtual'.
			
	cargoRepository := CGODirectoryPackageRepository basicNew
		instVarNamed: 'rootDirectory' put: cargoDirectory;
		initialize;
		yourself.
	self initializeCargoRepositoryVirtualIndex.
]

{ #category : #initialization }
GreaseTestResource >> initializeCargoRepositoryVirtualIndex [
	self cargoPackageVersions
		do: [ :pkgVersion | cargoRepository updateVirtualPackagesIndexWith: pkgVersion ]
]

{ #category : #accessing }
GreaseTestResource >> loadInstructions [
	^ STON fromString: self loadInstructionsStonString
]

{ #category : #accessing }
GreaseTestResource >> loadInstructionsFile [
	| file|
	file := fs / 'grease-load-instructions.ston'.
	file writeStreamDo: [ :stream | stream nextPutAll: self loadInstructionsStonString ].
	^ file
]

{ #category : #data }
GreaseTestResource >> loadInstructionsStonString [
	"Cargo new
		package: 'Grease-Slime';
		loadInstructions"
		
	^ 'CGOLoadInstructions {
	#groups : OrderedCollection [
		CGOPackageLoadGroup {
			#name : ''Grease-Core'',
			#packageVersions : [
				CGOPackageUnit {
					#package : #Grease-Core,
					#description : ''Core package of the Grease library.'',
					#version : ''1.1.13'',
					#timestamp : DateAndTime [ ''2015-04-14T14:51:50.116+00:00'' ],
					#dependencies : [ ],
					#src: CGOMonticelloHostedPackageVersion {
						#repository : CGOMonticelloRepository {
							#repositoryUrl : ''http://smalltalkhub.com/mc/Seaside/Grease11/main''
						},
						#packageName : #Grease-Core,
						#versionString : ''JohanBrichau.94''
					}
				}
			]
		},
		CGOPackageLoadGroup {
			#name : ''Grease-Pharo30-Core'',
			#packageVersions : [
				CGOPackageUnit {
					#package : #Grease-Pharo30-Core,
					#description : ''Platform-specific package of the Grease-Core package for Pharo.'',
					#version : ''1.1.13'',
					#timestamp : DateAndTime [ ''2015-05-11T14:56:14.307+00:00'' ],
					#dependencies : [
						#Grease-Core : [
							''=1.1.13''
						]
					],
					#src: CGOMonticelloHostedPackageVersion {
						#repository : CGOMonticelloRepository {
							#repositoryUrl : ''http://smalltalkhub.com/mc/Seaside/Grease11/main''
						},
						#packageName : #Grease-Pharo30-Core,
						#versionString : ''JohanBrichau.16''
					},
					#platformRequirements : [
						#pharo
					],
					#provisions : [
						#Grease-Core-Platform
					]
				}
			]
		},
		CGOPackageLoadGroup {
			#name : ''Grease-Pharo40-Slime'',
			#packageVersions : [
				CGOPackageUnit {
					#package : #Grease-Pharo40-Slime,
					#description : ''Slime uses the Refactoring Browser to find and, in some cases, rewrite common compatibility problems.'',
					#version : ''1.1.13'',
					#timestamp : DateAndTime [ ''2015-05-11T14:56:09.456+00:00'' ],
					#dependencies : [
						#Grease-Core-Platform : [
							''=1.1.13''
						]
					],
					#src: CGOMonticelloHostedPackageVersion {
						#repository : CGOMonticelloRepository {
							#repositoryUrl : ''http://smalltalkhub.com/mc/Seaside/Grease11/main''
						},
						#packageName : #Grease-Pharo40-Slime,
						#versionString : ''JohanBrichau.3''
					},
					#platformRequirements : [
						#pharo4.x
					],
					#provisions : [
						#Grease-Slime
					]
				}
			]
		}
	]
}'
]

{ #category : #data }
GreaseTestResource >> loadInstructionsStonStringNew [
	"Cargo new
		package: 'Grease-Slime';
		loadInstructions"
		
	^  'CGOLoadInstructions {
	#groups : OrderedCollection [
		CGOPackageLoadGroup {
			#name : ''Grease-Core'',
			#packageVersionRefs : [ ''Grease-Core@1.1.13'' ]
		},
		CGOPackageLoadGroup {
			#name : ''Grease-Pharo30-Core'',
			#packageVersionRefs : [ ''Grease-Pharo30-Core@1.1.13'' ]
		},
		CGOPackageLoadGroup {
			#name : ''Grease-Pharo40-Slime'',
			#packageVersionRefs : [ ''Grease-Pharo40-Slime@1.1.13'' ]
		}
	]
}'
]

{ #category : #data }
GreaseTestResource >> loadInstructionsStonStringOld [
	"Cargo new
		package: 'Grease-Slime';
		loadInstructions"
		
	^  'CGOLoadInstructions {
	#groups : OrderedCollection [
		CGOPackageLoadGroup {
			#name : ''Grease-Core'',
			#packageVersions : [
				CGOPackageUnit {
					#package : #Grease-Core,
					#description : ''Core package of the Grease library.'',
					#version : ''1.1.13'',
					#timestamp : DateAndTime [ ''2015-04-14T14:51:50.116+00:00'' ],
					#dependencies : [ ],
					#src: CGOMonticelloHostedPackageVersion {
						#repositoryUrl : ''http://smalltalkhub.com/mc/Seaside/Grease11/main'',
						#packageName : #Grease-Core,
						#versionString : ''JohanBrichau.94''
					}
				}
			]
		},
		CGOPackageLoadGroup {
			#name : ''Grease-Pharo30-Core'',
			#packageVersions : [
				CGOPackageUnit {
					#package : #Grease-Pharo30-Core,
					#description : ''Platform-specific package of the Grease-Core package for Pharo.'',
					#version : ''1.1.13'',
					#timestamp : DateAndTime [ ''2015-05-11T14:56:14.307+00:00'' ],
					#dependencies : [
						#Grease-Core : [
							''=1.1.13''
						]
					],
					#src: CGOMonticelloHostedPackageVersion {
						#repositoryUrl : ''http://smalltalkhub.com/mc/Seaside/Grease11/main'',
						#packageName : #Grease-Pharo30-Core,
						#versionString : ''JohanBrichau.16''
					},
					#platformRequirements : [
						#pharo
					],
					#provisions : [
						#Grease-Core-Platform
					]
				}
			]
		},
		CGOPackageLoadGroup {
			#name : ''Grease-Pharo40-Slime'',
			#packageVersions : [
				CGOPackageUnit {
					#package : #Grease-Pharo40-Slime,
					#description : ''Slime uses the Refactoring Browser to find and, in some cases, rewrite common compatibility problems.'',
					#version : ''1.1.13'',
					#timestamp : DateAndTime [ ''2015-05-11T14:56:09.456+00:00'' ],
					#dependencies : [
						#Grease-Core-Platform : [
							''=1.1.13''
						]
					],
					#src: CGOMonticelloHostedPackageVersion {
						#repositoryUrl : ''http://smalltalkhub.com/mc/Seaside/Grease11/main'',
						#packageName : #Grease-Pharo40-Slime,
						#versionString : ''JohanBrichau.3''
					},
					#platformRequirements : [
						#pharo4.x
					],
					#provisions : [
						#Grease-Slime
					]
				}
			]
		}
	]
}'
]

{ #category : #accessing }
GreaseTestResource >> mcRepository [
	^ mcRepository
]

{ #category : #building }
GreaseTestResource >> mcSnapshotMockFor: aPackageName [
	^ MCSnapshot
		fromDefinitions:
			(Array
				with: (MCOrganizationDefinition categories: (Array with: aPackageName asSymbol))
				with:
					(MCClassDefinition
						name: (aPackageName copyWithout: $-) asSymbol
						superclassName: #Object
						category: aPackageName asSymbol
						instVarNames: #()
						comment: ''))
]

{ #category : #building }
GreaseTestResource >> mcVersionFor: reference packages: packages [
	^ MCVersion new
		setPackage: 
			(packages 
				at: reference packageName
				ifAbsentPut: [ MCPackage new name: reference packageName ])
		info: (self mcVersionInfoMockFor: reference)
		snapshot: (self mcSnapshotMockFor: reference packageName)
		dependencies: #()
]

{ #category : #building }
GreaseTestResource >> mcVersionInfoMockFor: reference [
	^ MCVersionInfo
		name: reference printString
		id: UUID new
		message: 'This is a mock version'
		date: Date today
		time: Time now
		author: reference author
		ancestors: #()
]

{ #category : #data }
GreaseTestResource >> packageVersions [
	"create Cargo package version for theses packages using a MCDictionary repository"

	^ #( 'GoferBar.branch-lr.1'
		'GoferBar.branch-lr.2'
		'GoferBar-jf.1'
		'GoferBar-lr.1'
		'GoferFoo-lr.1'
		'GoferFoo-lr.2'
		'GoferFoo-lr.4'
		'Grease-Core-JohanBrichau.94'
		'Grease-Core-JohanBrichau.83'
		'Grease-Pharo30-Core-pmm.11'
		'Grease-Pharo30-Core-JohanBrichau.16'
		'Grease-Pharo40-Slime-JohanBrichau.3'
		'Grease-Slime-pmm.29'
		 ) 
		collect: [ :each |	CGOVersionReference named: each ]
]

{ #category : #'set-up' }
GreaseTestResource >> setUp [
	"This method builds a fake repository with the version references from #setUpVersionReferences."
	| packages |
	super setUp.
	packages := Dictionary new.
	mcRepository := MCDictionaryRepository new.
	self versionReferences
		do: [ :reference | mcRepository basicStoreVersion: (self mcVersionFor: reference packages: packages) ]
]

{ #category : #data }
GreaseTestResource >> versionReferences [
	"This method answers a collection of unique references in the order they should be sorted. It includes two different packages (Gofer-Foo, Gofer-Bar), linear series of packages (Gofer-Foo-lr.1, Gofer-Foo-lr.2, Gofer-Foo-lr.4), packages with a branch (Gofer-Bar.branch-lr.1,Gofer.branch-Bar-lr.2), and packages with the same version but different authors (Gofer-Bar-jf.1, Gofer-Bar-lr.1)."

	^ #( 'GoferBar.branch-lr.1'
		'GoferBar.branch-lr.2'
		'GoferBar-jf.1'
		'GoferBar-lr.1'
		'GoferFoo-lr.1'
		'GoferFoo-lr.2'
		'GoferFoo-lr.4'
		'Grease-Core-JohanBrichau.94'
		'Grease-Core-JohanBrichau.83'
		'Grease-Pharo30-Core-pmm.11'
		'Grease-Pharo30-Core-JohanBrichau.16'
		'Grease-Pharo40-Slime-JohanBrichau.3'
		'Grease-Slime-pmm.29'
		 ) 
		collect: [ :each |	CGOVersionReference named: each ]
]

{ #category : #initialization }
GreaseTestResource >> writePackageVersions: aListOfPackageVersions to: aFolder [
	aListOfPackageVersions
		do: [ :pkgVersion |
			(aFolder / pkgVersion packageName asLowercase) ensureCreateDirectory.
			aFolder / pkgVersion packageName asLowercase / pkgVersion name asLowercase
				writeStreamDo: [ :stream | stream nextPutAll: (PBPackageVersionWriterV1 toStringPretty: pkgVersion) ] ].
]
