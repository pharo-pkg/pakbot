"
tests of PBIcebergProject
"
Class {
	#name : #PBIcePakbotProjectTest,
	#superclass : #TestCase,
	#instVars : [
		'iceRepositoryLocation',
		'repository',
		'pakbotProject'
	],
	#category : #'Pakbot-Tests-Iceberg-Integration'
}

{ #category : #accessing }
PBIcePakbotProjectTest >> iceRepositoryLocation [
	^ iceRepositoryLocation
		ifNil: [ iceRepositoryLocation := FileLocator temp
				/ ('pharo-tests-' , DateAndTime now asFileNameCompatibleString) ]
]

{ #category : #running }
PBIcePakbotProjectTest >> setUp [
	repository := IceRepositoryCreator new 
			addRemote: 'https://github.com/pharo-pkg/pharo-counter.git';
			location: self iceRepositoryLocation;
			subdirectory: '';
			createRepository.
			
	pakbotProject := (PBGitRepository url: repository origin url repository: repository) project

]

{ #category : #accessing }
PBIcePakbotProjectTest >> tearDown [
	repository ifNotNil: [:repo | repo forget].
	iceRepositoryLocation ensureDeleteAll
]

{ #category : #tests }
PBIcePakbotProjectTest >> testCanDetectAChangeInPakbotProjectMetatadata [
	| project diff projectNode |

	pakbotProject description: 'foo'.
	
	project := PBIcebergProject onRepository: repository project: pakbotProject.
	repository workingCopy basicSetProject: project.
	
	diff := IceDiff from: repository workingCopy to: repository headCommit.

	self deny: diff isEmpty.
	self 
		assert: diff tree children size
		equals: 1.
		
	projectNode := diff tree children first.
	self assert: projectNode children isEmpty.
	self assert: projectNode hasChanges
]

{ #category : #tests }
PBIcePakbotProjectTest >> testNoChangeDetectedInPakbotProjectMetatadataWhenMetadataUnchanged [
	| project |

	project := PBIcebergProject onRepository: repository project: pakbotProject.
	repository workingCopy basicSetProject: project.

	self assert: repository workingCopyDiff isEmpty.
]
