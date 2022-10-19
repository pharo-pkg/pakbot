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
	
	PBNewDependencyPresenter new 
		openDialogOnAccept: [ :dependency |
			self packageVersion addDependency: dependency.
			self refreshUI ]
		onCancel: [ "Nothing" ]
]

{ #category : #actions }
PBPackageDependenciesView >> editAction [
	"only one fixed constraint managed for now"
	| dependency |
	dependency := self selectedPackage.
	dependency newEditPanel openDialog
		okAction: [ "TODO: update dependency from presenter values". self updatePresenter ];
		cancelAction: [  ]
]

{ #category : #refreshing }
PBPackageDependenciesView >> refreshUI [
	
	packageList refresh
]

{ #category : #actions }
PBPackageDependenciesView >> removeAction: aDependency [ 

	self packageVersion removeDependency: aDependency.
	self refreshUI.
]

{ #category : #'private - building' }
PBPackageDependenciesView >> roots [
	
	^ self packageVersion 
		ifNil: [ #() ]
		ifNotNil: [ :packageVersion | packageVersion dependencies ]
]
