"
A simple menu group entry for Pkabot in Iceberg
"
Class {
	#name : #PBIcebergPakbotMenuGroup,
	#superclass : #CmdMenuGroup,
	#category : #'CargoPackageManager-Iceberg-Integration'
}

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
