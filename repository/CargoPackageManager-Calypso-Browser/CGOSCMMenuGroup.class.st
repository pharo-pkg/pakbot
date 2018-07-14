"
I am a menu group gathering together all SCM menu items (like commit, pull, push).
"
Class {
	#name : #CGOSCMMenuGroup,
	#superclass : #CmdMenuGroup,
	#category : 'CargoPackageManager-Calypso-Browser'
}

{ #category : #accessing }
CGOSCMMenuGroup >> name [
	^'Git SCM'
]

{ #category : #accessing }
CGOSCMMenuGroup >> order [

	^ 10000
]
