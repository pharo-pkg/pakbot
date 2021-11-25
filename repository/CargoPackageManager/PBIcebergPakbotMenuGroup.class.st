"
A simple menu group entry for Pkabot in Iceberg
"
Class {
	#name : #PBIcebergPakbotMenuGroup,
	#superclass : #CmdMenuGroup,
	#category : #'CargoPackageManager-Iceberg-Integration'
}

{ #category : #adding }
PBIcebergPakbotMenuGroup >> addCommandsForRepository: anIceTipRepositoryModel intoGroup: aSpCommandGroup [
	{ PBDisablePakbotProjectCommand . PBEnablePakbotProjectCommand }
		do: [ :command | 
			aSpCommandGroup register: (self specCommandFor: command context: anIceTipRepositoryModel) ].
]

{ #category : #accessing }
PBIcebergPakbotMenuGroup >> description [

	^ 'Pakbot operations'
]

{ #category : #accessing }
PBIcebergPakbotMenuGroup >> name [

	^ 'Pakbot'
]

{ #category : #accessing }
PBIcebergPakbotMenuGroup >> order [
	"Plugins are SmallInteger maxVal - 2000 .. SmallInteger maxVal"
	^ SmallInteger maxVal - 1100
]

{ #category : #'as yet unclassified' }
PBIcebergPakbotMenuGroup >> specCommandFor: aCmCommand context: anIceTipRepositoryModel [
	 ^ (aCmCommand forSpecWithIconNamed: aCmCommand defaultIconName)
		context: anIceTipRepositoryModel;
		yourself
]
