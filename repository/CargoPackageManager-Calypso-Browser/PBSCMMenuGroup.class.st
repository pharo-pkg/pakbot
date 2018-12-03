"
I am a menu group gathering together all SCM menu items (like commit, pull, push).
"
Class {
	#name : #PBSCMMenuGroup,
	#superclass : #CmdMenuGroup,
	#category : #'CargoPackageManager-Calypso-Browser-Menu'
}

{ #category : #accessing }
PBSCMMenuGroup >> name [
	^'Git SCM'
]

{ #category : #accessing }
PBSCMMenuGroup >> order [

	^ 10000
]
