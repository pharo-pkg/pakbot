Class {
	#name : #LoadInstructionsBuilderSeaside31Test,
	#superclass : #Seaside31BasedTest,
	#instVars : [
		'resolution',
		'sorter'
	],
	#category : 'CargoPackageManager-FailingTests-Functional'
}

{ #category : #utility }
LoadInstructionsBuilderSeaside31Test >> assertPackage: aPackage equals: aPackageVersionString [
	| anotherPackage |
	
	anotherPackage := aPackageVersionString asPackageVersionReference.
	
	self assert: aPackage packageName equals: anotherPackage packageName.
	self assert: aPackage version equals: anotherPackage versionNumber.
]

{ #category : #'expected results' }
LoadInstructionsBuilderSeaside31Test >> expectedSortResult [
	"self collect: [ :item | item packageVersion packageName , '@' , item packageVersion version asString]"
	^ #('Grease-Pharo30-Core@1.1.5' 'Seaside-Pharo20-Core@3.1.0' 'Grease-Core@1.1.5' 'Seaside-Pharo-Canvas@3.1.0' 'Seaside-Core@3.1.0' 'Seaside-Canvas@3.1.0' 'Seaside-Component@3.1.0' 'Seaside-Session@3.1.0' 'Javascript-Pharo20-Core@3.1.0' 'Seaside-Pharo-Continuation@3.1.0' 'Seaside-Pharo-Tools-Spec@3.1.0' 'Seaside-RenderLoop@3.1.0' 'Javascript-Core@3.1.0' 'Seaside-Pharo-Flow@3.1.0' 'Seaside-Tools-Core@3.1.0' 'Seaside-Pharo20-Tools-Web@3.1.0' 'Seaside-Widgets@3.1.0' 'Zinc-Resource-Meta-Core@2.4.8' 'Zinc-Character-Encoding@2.4.8' 'JQuery-Core@3.1.0' 'Seaside-Pharo-Development@3.1.0' 'Seaside-Flow@3.1.0' 'Seaside-Tools-Web@3.1.0' 'Seaside-Pharo-Environment@3.1.0' 'Zinc-HTTP@2.4.8' 'Seaside-Pharo-Welcome@3.1.0' 'JQuery-UI@3.1.0' 'Seaside-Development@3.1.0' 'Seaside-Examples@3.1.0' 'Seaside-Environment@3.1.0' 'Zinc-Seaside@3.1.0' 'Seaside-Welcome@3.1.0' 'Seaside-Group-Default@3.1.0' 'Seaside31@3.1.0')
	
	"#('Grease-Core@1.1.5' 'Seaside-Core@3.1.0' 'Seaside-Canvas@3.1.0' 'Seaside-Component@3.1.0' 'Seaside-Session@3.1.0' 'Seaside-RenderLoop@3.1.0' 'Javascript-Core@3.1.0' 'Seaside-Pharo-Continuation@3.1.0' 'Seaside-Tools-Core@3.1.0' 'Seaside-Widgets@3.1.0' 'Zinc-Resource-Meta-Core@2.4.8' 'Zinc-Character-Encoding@2.4.8' 'JQuery-Core@3.1.0' 'Seaside-Flow@3.1.0' 'Seaside-Tools-Web@3.1.0' 'Zinc-HTTP@2.4.8' 'JQuery-UI@3.1.0' 'Seaside-Development@3.1.0' 'Seaside-Examples@3.1.0' 'Seaside-Environment@3.1.0' 'Zinc-Seaside@3.1.0' 'Seaside-Welcome@3.1.0' 'Seaside-Group-Default@3.1.0' 'Seaside31@3.1.0')
"
]

{ #category : #running }
LoadInstructionsBuilderSeaside31Test >> setUp [
	super setUp.
	Cargo platformAttributes: #(#squeakCommon #pharo #'pharo4.x' #'pharo4.0.x').
	resolution := PBSolver new 
					repositories: { repository };
					solveDependency: seaside31Dependency.
	sorter := CGOLoadInstructionsBuilder new
					resolution: resolution;
					yourself
]

{ #category : #running }
LoadInstructionsBuilderSeaside31Test >> tearDown [
	super tearDown.
	Cargo platformAttributes: nil
]

{ #category : #tests }
LoadInstructionsBuilderSeaside31Test >> testLoadInstructions [
	| loadInstructions pkgVersionReferences |

	loadInstructions := sorter loadInstructions.
	self assert: loadInstructions groups size equals: 34.
	pkgVersionReferences := loadInstructions groups flatCollect: [ :aPackageGroup | aPackageGroup packageVersions ].
	pkgVersionReferences withIndexDo: 
		[ :pkgVersionReference :index | 
		self
			assert: pkgVersionReference asString
			equals: (self expectedSortResult at: index) ].
]

{ #category : #tests }
LoadInstructionsBuilderSeaside31Test >> testLoadOrder [
	| packages |

	packages := sorter loadOrder flattened collect: #resolvedProjectVersion.
	"self assert: packages equals: #()"
	1 to: packages size do: [ :index |
		self 
			assertPackage: (packages at: index)
			equals: (self expectedSortResult at: index) ]
]
