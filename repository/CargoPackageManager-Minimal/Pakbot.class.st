"
Pakbot Package Manager.

I'm the entry point to deal with project management using code.
If you prefer a GUI, please use the project view from the system browser.
"
Class {
	#name : #Pakbot,
	#superclass : #Object,
	#classVars : [
		'PlatformAttributes'
	],
	#classInstVars : [
		'pakbotAnnouncer'
	],
	#category : #'CargoPackageManager-Minimal'
}

{ #category : #accessing }
Pakbot class >> announcer [

	^ pakbotAnnouncer ifNil: [ pakbotAnnouncer := Announcer new ]
]

{ #category : #accessing }
Pakbot class >> defaultPackageRepository [
	^ PBPackageRepository default
]

{ #category : #private }
Pakbot class >> platformAttributes [
	^ PlatformAttributes ifNil: [ PlatformAttributes := Smalltalk image metacelloPlatformAttributes ]
]

{ #category : #private }
Pakbot class >> platformAttributes: aListOfPlatformAttributes [
	PlatformAttributes := aListOfPlatformAttributes
]

{ #category : #resetting }
Pakbot class >> resetAnnouncer [
	<script>
	pakbotAnnouncer := nil.
]
