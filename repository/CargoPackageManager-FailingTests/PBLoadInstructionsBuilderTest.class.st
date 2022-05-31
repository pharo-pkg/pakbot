Class {
	#name : #PBLoadInstructionsBuilderTest,
	#superclass : #Seaside31BasedTest,
	#instVars : [
		'resolution',
		'loadInstructionsBuilder'
	],
	#category : #'CargoPackageManager-FailingTests-Loader'
}

{ #category : #accessing }
PBLoadInstructionsBuilderTest class >> resources [
	^ super resources copyWith: FooDependencyResolutionResource
]

{ #category : #utility }
PBLoadInstructionsBuilderTest >> assertPackage: aPackage equals: aPackageVersionString [
	| anotherPackage |
	
	anotherPackage := aPackageVersionString asPackageVersionReference.
	
	self assert: aPackage packageName equals: anotherPackage packageName.
	self assert: aPackage version equals: anotherPackage versionNumber.
]

{ #category : #'expected results' }
PBLoadInstructionsBuilderTest >> expectedSortResult [
	"self collect: [ :item | item packageVersion packageName , '@' , item packageVersion version asString]"
	^ #('B@3.1.0' 'D@1.1.0' 'C@1.0.0' 'E@1.0.0' 'A@1.0.0' 'Foo@1.0.0')
]

{ #category : #running }
PBLoadInstructionsBuilderTest >> setUp [
	super setUp.
	loadInstructionsBuilder := PBLoadInstructionsBuilder new
					resolution: FooDependencyResolutionResource current dependencyResolution;
					yourself
]

{ #category : #tests }
PBLoadInstructionsBuilderTest >> testLoadInstructions [
	| loadInstructions pkgVersionReferences |

	loadInstructions := loadInstructionsBuilder loadInstructions.
	self assert: loadInstructions groups size equals: 5.
	pkgVersionReferences := loadInstructions groups 
		flatCollect: [ :aPackageGroup | aPackageGroup packageVersions ].
	self
		assert: (pkgVersionReferences collect: #asString as: Array)
		equals: self expectedSortResult.
]

{ #category : #tests }
PBLoadInstructionsBuilderTest >> testLoadOrder [
	| packages |

	packages := loadInstructionsBuilder loadOrder flattened collect: #resolvedProjectVersion.
	"self assert: packages equals: #()"
	1 to: packages size do: [ :index |
		self 
			assertPackage: (packages at: index)
			equals: (self expectedSortResult at: index) ].
]

{ #category : #tests }
PBLoadInstructionsBuilderTest >> testLoadOrderHandlesCycles [
	self 
		shouldnt: [ loadInstructionsBuilder loadOrder ]
		raise: MessageNotUnderstood
]

{ #category : #tests }
PBLoadInstructionsBuilderTest >> testReducedGraph [
	| nodes |

	nodes := loadInstructionsBuilder reducedGraph.
	self 
		assert: (nodes 
			collect: [ :node | 
				node model isCollection
					ifTrue: [ node model collect: #asString as: Array ]
					ifFalse: [ node asString ] ]
			as: Array)
		equals: #('Foo@1.0.0' 'A@1.0.0' 'C@1.0.0' 'E@1.0.0' #('B@3.1.0' 'D@1.1.0'))
]
