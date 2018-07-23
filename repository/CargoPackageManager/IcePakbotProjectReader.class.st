"
I am a project reader that is used to read a Pakbot project.
I create an IcePakbotProject in case a project metadata file is found.
"
Class {
	#name : #IcePakbotProjectReader,
	#superclass : #IceProjectReader,
	#instVars : [
		'properties'
	],
	#category : #CargoPackageManager
}

{ #category : #testing }
IcePakbotProjectReader >> canReadProjectFromCommitish: aCommitish [
	 
	^ (IcePakbotProject onCommitish: aCommitish) projectFileReference exists

]

{ #category : #reading }
IcePakbotProjectReader >> readProjectFromCommitish: aCommitish [
	| projectFileReference pakbotProject version |
	projectFileReference := (IcePakbotProject onCommitish: aCommitish)
		projectFileReference.
	projectFileReference
		binaryReadStreamDo: [ :stream | 
			| stonReader |
			stonReader := STON reader
				on: (ZnCharacterReadStream on: stream encoding: 'utf8').
			version := stonReader next at: #version.
			properties := stonReader next ].
	pakbotProject := CGOPackageVersionWriterV1
		deserializeProject: properties
		version: version.
	^ (IcePakbotProject onCommitish: aCommitish project: pakbotProject)
		sourceDirectory: (self srcDirectoryFromCommitish: aCommitish);
		yourself
]

{ #category : #private }
IcePakbotProjectReader >> srcDirectoryFromCommitish: aCommitish [
	properties at: 'srcDirectory' ifPresent: [ :srcDir | ^ srcDir ].
	^ (IceBasicProjectReader new canReadProjectFromCommitish: aCommitish) 
		ifTrue: [ (IceBasicProjectReader new readProjectFromCommitish: aCommitish) sourceDirectory ]
		ifFalse: [ 'src' ]
]
