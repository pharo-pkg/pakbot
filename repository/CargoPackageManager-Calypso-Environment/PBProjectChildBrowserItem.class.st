Class {
	#name : #PBProjectChildBrowserItem,
	#superclass : #Object,
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #sorting }
PBProjectChildBrowserItem class >> defaultSortFunctionForCalypso [
	^ClySortByNameFunction ascending
]
