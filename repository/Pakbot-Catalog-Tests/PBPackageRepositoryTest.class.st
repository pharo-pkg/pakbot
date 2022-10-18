Class {
	#name : #PBPackageRepositoryTest,
	#superclass : #TestCase,
	#instVars : [
		'repository'
	],
	#category : #'Pakbot-Catalog-Tests'
}

{ #category : #helper }
PBPackageRepositoryTest >> publishProjects: aListOfProjects [

	| registry |
	registry := PBPackageRegistry new.

	aListOfProjects do: [ :association | 
		association value do: [ :version | repository registerFakePackage: association key version: version ] ]
]

{ #category : #running }
PBPackageRepositoryTest >> setUp [
	super setUp.
	
	repository := PBPackageRepository newLocalRepositoryIn: FileSystem memory root.

]

{ #category : #tests }
PBPackageRepositoryTest >> tempIceRepository [
	"| fs |
	fs := FileSystem memory root.
	^ IceLibgitRepository new
		name: 'temp-git-repo';
		location: fs;
		init;
		yourself."
	^ PBGitRepository example
]

{ #category : #tests }
PBPackageRepositoryTest >> testCanCreateALocalRepository [

	repository := PBPackageRepository newLocalRepositoryIn: FileSystem memory root.
	
	self 
		assert: repository packages size 
		equals: 0
]

{ #category : #tests }
PBPackageRepositoryTest >> testCanFetchAProject [
	| project published |

	project := PBProjectVersion example.
	project 
		version: '1.0' asSemanticVersion;
		registry: PBPackageRegistry new;
		repository: 	PBGitRepository example;
		publishOn: repository.
	
	published := repository fetch: project name version: project version.

	self
		assert: published name
		equals: project name.
	self
		assert: published version
		equals: project version.
]

{ #category : #tests }
PBPackageRepositoryTest >> testCanListPackageVersions [

	| versions |
	versions := #('1.0' '2.0' '2.1' '2.2' '3.0' '3.0.1' '3.1' '4.0').
	
	self publishProjects: 
		{ #project1 -> #('1.0' '1.0.1') .
		#project2 -> #('2.0') .
		#project3 -> versions }.
		
	self
		assertCollection: (repository versionsOf: #project3)
		hasSameElements: versions
]

{ #category : #tests }
PBPackageRepositoryTest >> testCanListPackages [

	self publishProjects: 
		{ #project1 -> #('1.0' '1.0.1') .
		#project2 -> #('2.0') .
		#project3 -> #('1.0' '2.0' '2.1' '2.2' '3.0' '3.0.1' '3.1' '4.0') }.
		
	self
		assertCollection: repository packages
		hasSameElements: #(project1 project2 project3)
		
]

{ #category : #tests }
PBPackageRepositoryTest >> testCanListUnknownPackageThrowsPackageNotFoundError [

	| versions |
	versions := #('1.0' '2.0' '2.1' '2.2' '3.0' '3.0.1' '3.1' '4.0').
	
	self publishProjects: 
		{ #project1 -> #('1.0' '1.0.1') .
		#project2 -> #('2.0') .
		#project3 -> versions }.
		
	self
		should: [ repository versionsOf: #unknownProject ]
		raise: PBPackageNotFoundError
]

{ #category : #tests }
PBPackageRepositoryTest >> testCanPublishAProject [ 
	| project published |

	project := PBProjectVersion example.
	project
		registry: PBPackageRegistry new;
		repository: 	PBGitRepository example;
		version: '0.1' asSemanticVersion;
		publishOn: repository.
	
	self 
		assert: repository packages size 
		equals: 1.
		
	published := repository fetch: project name version: project version.

	self
		assert: published name
		equals: project name.
	self
		assert: published version
		equals: project version.

	self 
		assert: published class
		equals: PBProjectVersion.
	self 
		assertCollection: published packageNames
		hasSameElements: #(#UnitTest)
]

{ #category : #tests }
PBPackageRepositoryTest >> testCannotPublishAProjectHavingNonFixedVersion [
	| project |

	project := PBProjectVersion example.
	project
		registry: PBPackageRegistry new;
		version: PBNoVersion new;
		repository: 	PBGitRepository example.
	
	self 
		should: [ project publishOn: repository ]
		raise: PBPublicationError.
	
	self assert: repository packages isEmpty

]

{ #category : #tests }
PBPackageRepositoryTest >> testCannotPublishAProjectWhenHavingDependencyOnNonFixedVersion [
	self flag: 'TODO'.
	self skip

]

{ #category : #tests }
PBPackageRepositoryTest >> testCannotPublishAProjectWhenVersionAlreadyPublished [
	| project |

	project := PBProjectVersion example.
	project
		registry: PBPackageRegistry new;
		repository: 	PBGitRepository example;
		version: '0.1' asSemanticVersion;	
		publishOn: repository.
	
	self 
		assert: repository packages size 
		equals: 1.
		
	self
		should: [ project publishOn: repository ]
		raise: PBPublicationError
]

{ #category : #tests }
PBPackageRepositoryTest >> testCannotPublishAProjectWithNoRepository [ 
	| project |

	project := PBProjectVersion example.
	project 
		registry: PBPackageRegistry new;
		version: '0.1' asSemanticVersion.
	
	self 
		should: [ project publishOn: repository ]
		raise: PBError
		whoseDescriptionIncludes: 'no repository defined'
		description: 'Did not get right exception when trying to publish a project with no repository set'.

]

{ #category : #tests }
PBPackageRepositoryTest >> testProjectNotPublishedWhenAnErrorOccursDuringPublication [
	| project |

	project := PBProjectVersion example.
	project version: PBNoVersion new.
	project 
		registry: PBPackageRegistry new;
		repository: 	PBGitRepository example.
	
	self 
		should: [ project publishOn: repository ]
		raise: PBPublicationError
		whoseDescriptionIncludes: 'no version defined!'
		description: 'No error signaled when publishing a project with no fixed version'.
		
	self deny: (repository fileForPackageNamed: project name version: project version asString) exists

]

{ #category : #tests }
PBPackageRepositoryTest >> testPublishedProjectHasASourceRepository [
	| project fetchedProject |

	project := PBProjectVersion example.
	project
		registry: PBPackageRegistry new;
		repository: self tempIceRepository;
		version: '1.1';
		publishOn: repository.
		
	fetchedProject := repository
		fetch: project name
		version: project version.
		
	self assert: fetchedProject repository isValidRepository
]
