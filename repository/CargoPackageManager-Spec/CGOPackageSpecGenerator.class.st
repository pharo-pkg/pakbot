"
A PackageSpecGenerator is used to generate PackageSpec stubs.

"
Class {
	#name : #CGOPackageSpecGenerator,
	#superclass : #Object,
	#instVars : [
		'package',
		'class'
	],
	#category : 'CargoPackageManager-Spec'
}

{ #category : #'as yet unclassified' }
CGOPackageSpecGenerator class >> generateFor: aPackageName withDependencies: dependencies [
		self new
			package: aPackageName;
			createClass;
			addDependencies: dependencies;
			addNameMethod;
			addVersionMethod;
			yourself.
]

{ #category : #'as yet unclassified' }
CGOPackageSpecGenerator >> addDependencies: packagesName [
	| methodText |
	
	methodText := 'dependencies
'.
	packagesName do: [ :packageName |
		methodText := methodText ,
			'	(package addDependency: ''' , packageName , ''')
' ,
			'		addFixedVersionConstraint: '''';
		yourself.
' ].
	class compile: methodText.
]

{ #category : #'as yet unclassified' }
CGOPackageSpecGenerator >> addNameMethod [
	class compile: 'name
	^ ''' , package , ''''
]

{ #category : #'as yet unclassified' }
CGOPackageSpecGenerator >> addVersionMethod [
	class compile: 'version
	package version: '''''
]

{ #category : #'as yet unclassified' }
CGOPackageSpecGenerator >> createClass [
	| className |
	className := (self normalizedPackageName: package) , 'Spec'.
	class := CGOPackageSpec
		subclass: className asSymbol
		instanceVariableNames: ''
		classVariableNames: ''
		poolDictionaries: ''
		category: 'PackagesManager-SeasideDescription'.
]

{ #category : #'as yet unclassified' }
CGOPackageSpecGenerator >> normalizedPackageName: name [
	^name reject: [ :char | char = $- ]
]

{ #category : #'as yet unclassified' }
CGOPackageSpecGenerator >> package: aString [
	package := aString
]
