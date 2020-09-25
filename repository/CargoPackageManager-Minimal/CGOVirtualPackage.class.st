"
A virtual package is a generic name that applies to any one of a group of packages, all of which provide similar basic functionality. For example, both the tin and trn programs are news readers, and should therefore satisfy any dependency of a program that required a news reader on a system, in order to work or to be useful. They are therefore both said to provide the ""virtual package"" called news-reader.
"
Class {
	#name : #CGOVirtualPackage,
	#superclass : #CGOPackage,
	#category : #'CargoPackageManager-Minimal-Model'
}

{ #category : #testing }
CGOVirtualPackage >> isVirtual [
	^ true
]

{ #category : #accessing }
CGOVirtualPackage >> platformSuffix [
	^ '-Platform'
]

{ #category : #printing }
CGOVirtualPackage >> printOn: aStream [
	aStream << name << ' (virtual)'
]
