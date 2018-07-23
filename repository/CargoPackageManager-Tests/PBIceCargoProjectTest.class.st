Class {
	#name : #PBIceCargoProjectTest,
	#superclass : #TestCase,
	#instVars : [
		'iceRepositoryLocation',
		'repository',
		'pakbotProject'
	],
	#category : #'CargoPackageManager-Tests-Model-Serialization'
}

{ #category : #accessing }
PBIceCargoProjectTest >> iceRepositoryLocation [
	^ iceRepositoryLocation
		ifNil: [ iceRepositoryLocation := FileLocator temp
				/ ('pharo-tests-' , DateAndTime now asFileNameCompatibleString) ]
]

{ #category : #running }
PBIceCargoProjectTest >> setUp [
	repository := IceRepositoryCreator new 
			addRemote: 'https://github.com/demarey/pharo-counter.git';
			location: self iceRepositoryLocation;
			subdirectory: '';
			createRepository.
			
	pakbotProject := (CGOGitRepository url: repository origin url repository: repository) project

]

{ #category : #accessing }
PBIceCargoProjectTest >> tearDown [
	repository forget.
	iceRepositoryLocation ensureDeleteAll
]

{ #category : #tests }
PBIceCargoProjectTest >> testCanDetectAChangeInPakbotProjectMetatadata [
	| project diff projectNode |

	pakbotProject description: 'foo'.
	
	project := IcePakbotProject onRepository: repository project: pakbotProject.
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
PBIceCargoProjectTest >> testNoChangeDetectedInPakbotProjectMetatadataWhenMetadataUnchanged [
	| project |

	project := IcePakbotProject onRepository: repository project: pakbotProject.
	repository workingCopy basicSetProject: project.
	
	self assert: repository workingCopyDiff isEmpty.
]
