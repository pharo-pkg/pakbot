"
A LoadInstructionsSeaside31Test is xxxxxxxxx. 

Instance Variables
	loadInstructions:		<Object>
	pkgRepository:		<Object>

loadInstructions
	- xxxxx

pkgRepository
	- xxxxx

"
Class {
	#name : #LoadInstructionsSeaside31Test,
	#superclass : #RepositoryBasedTest,
	#instVars : [
		'pkgRepository',
		'loadInstructions'
	],
	#category : 'CargoPackageManager-FailingTests-Functional'
}

{ #category : #accessing }
LoadInstructionsSeaside31Test >> input [
	"Seaside31 resolution"
	^  'CGOLoadInstructions {
	#groups : OrderedCollection [
		CGOPackageLoadGroup {
			#name : #Grease-Core,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Grease-Core,
					#version : ''1.1.5''
				},
				CGOPackageVersionReference {
					#packageName : #Grease-Pharo30-Core,
					#version : ''1.1.5''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Seaside-Core,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Seaside-Core,
					#version : ''3.1.0''
				},
				CGOPackageVersionReference {
					#packageName : #Seaside-Pharo20-Core,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Seaside-Canvas,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Seaside-Canvas,
					#version : ''3.1.0''
				},
				CGOPackageVersionReference {
					#packageName : #Seaside-Pharo-Canvas,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Seaside-Session,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Seaside-Session,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Seaside-Component,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Seaside-Component,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Seaside-RenderLoop,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Seaside-RenderLoop,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Javascript-Core,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Javascript-Core,
					#version : ''3.1.0''
				},
				CGOPackageVersionReference {
					#packageName : #Javascript-Pharo20-Core,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Seaside-Pharo-Continuation,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Seaside-Pharo-Continuation,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Seaside-Tools-Core,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Seaside-Tools-Core,
					#version : ''3.1.0''
				},
				CGOPackageVersionReference {
					#packageName : #Seaside-Pharo-Tools-Spec,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Seaside-Widgets,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Seaside-Widgets,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Zinc-Resource-Meta-Core,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Zinc-Resource-Meta-Core,
					#version : ''2.4.8''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Zinc-Character-Encoding,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Zinc-Character-Encoding,
					#version : ''2.4.8''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #JQuery-Core,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #JQuery-Core,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Seaside-Flow,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Seaside-Flow,
					#version : ''3.1.0''
				},
				CGOPackageVersionReference {
					#packageName : #Seaside-Pharo-Flow,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Seaside-Tools-Web,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Seaside-Tools-Web,
					#version : ''3.1.0''
				},
				CGOPackageVersionReference {
					#packageName : #Seaside-Pharo20-Tools-Web,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Zinc-HTTP,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Zinc-HTTP,
					#version : ''2.4.8''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #JQuery-UI,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #JQuery-UI,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Seaside-Development,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Seaside-Development,
					#version : ''3.1.0''
				},
				CGOPackageVersionReference {
					#packageName : #Seaside-Pharo-Development,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Seaside-Examples,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Seaside-Examples,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Seaside-Environment,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Seaside-Environment,
					#version : ''3.1.0''
				},
				CGOPackageVersionReference {
					#packageName : #Seaside-Pharo-Environment,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Zinc-Seaside,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Zinc-Seaside,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Seaside-Welcome,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Seaside-Welcome,
					#version : ''3.1.0''
				},
				CGOPackageVersionReference {
					#packageName : #Seaside-Pharo-Welcome,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Seaside-Group-Default,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Seaside-Group-Default,
					#version : ''3.1.0''
				}
			]
		},
		CGOPackageLoadGroup {
			#name : #Seaside31,
			#packageVersions : [
				CGOPackageVersionReference {
					#packageName : #Seaside31,
					#version : ''3.1.0''
				}
			]
		}
	]
}'
]

{ #category : #running }
LoadInstructionsSeaside31Test >> setUp [
	super setUp.
	loadInstructions := STON fromString: self input
]

{ #category : #tests }
LoadInstructionsSeaside31Test >> testLoad [
	^ self skip.
	"loadInstructions mcVersions"
]
