"
I display and allow edition of dependencies of the provided PackageVersion.
"
Class {
	#name : #PBPackageDependenciesView,
	#superclass : #PBPackageListEditor,
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #example }
PBPackageDependenciesView class >> example [
	| package registry project |
	
	registry := PBPackageRegistry new.
	project := PBProjectVersion named: #Foo.
	registry register: project.
	package := PBPackage example.
	package project registry: registry.
	package addDependencyOn: #Foo.
	
	^ (self on: package) open
]

{ #category : #actions }
PBPackageDependenciesView >> addAction [
	
	PBNewDependencyDialog new 
		openDialogOnAccept: [ :dependency |
			self packageVersion addDependency: dependency buildDependency.
			self refreshUI ]
		onCancel: [ "Nothing" ]
]

{ #category : #actions }
PBPackageDependenciesView >> editAction [
	"only one fixed constraint managed for now"
	| dependency |
	dependency := self selectedPackage.
	dependency newEditPanel
		openDialogOnAccept: [ :modifiedDependency |
			self refreshUI ]
		onCancel: [  ]
]

{ #category : #actions }
PBPackageDependenciesView >> removeAction: aCGOPackageDependency [ 
	self packageVersion removeDependency: aCGOPackageDependency
]

{ #category : #'private - building' }
PBPackageDependenciesView >> roots [
	
	^ self packageVersion 
		ifNil: [ #() ]
		ifNotNil: [ :packageVersion | packageVersion dependencies ]
]
