"
A PackageSpec is used to describe a package specification.
It can be instantiated from a JSON file or exported to a JSON file.

"
Class {
	#name : #CGOPackageSpec,
	#superclass : #Object,
	#instVars : [
		'package',
		'dictionary'
	],
	#category : 'CargoPackageManager-Spec'
}

{ #category : #converting }
CGOPackageSpec >> asPackageVersion [
	^ CGOPackageUnit newFrom:
	( Dictionary new
			add: #package -> self packageName asSymbol;
			add: #version -> self version;
			add: #dependencies -> self dependencies;
			add: #provisions -> (self provisions collect: [ :p | (CGOPackageVersionReference newOn: p) asString]);
			add: #description -> self description;
			add: #sourcePackageVersion -> self sourcePackageVersionObject;
			add: #platformRequirements -> self platformRequirements;
			add: #timestamp -> DateAndTime now;
			yourself )
]

{ #category : #spec }
CGOPackageSpec >> authors [
	"package addAuthorName: 'Demarey' firstname: 'Christophe'"
]

{ #category : #builder }
CGOPackageSpec >> buildPackage [
	^ self asPackageVersion
]

{ #category : #compatibility }
CGOPackageSpec >> cargoSourcePackageForSpec: aPackageSpec [
	"Package spec defined a list os rouce repositories. It has been replaced by Cargo Source Package Version having an abstraction on the VCS backend and additional data. To avaoid to update all specs, use this method to generate the expecte data."
	^ CGOMonticelloHostedPackageVersion 
		repositoryUrl: aPackageSpec repositories first
		packageName: (aPackageSpec file copyUpToLast: $-)
		versionString: (aPackageSpec file copyAfterLast: $-)
]

{ #category : #spec }
CGOPackageSpec >> contributors [
	"package addContributorName: 'Demarey' firstname: 'Christophe'"
]

{ #category : #spec }
CGOPackageSpec >> dependencies [
	^ #()
]

{ #category : #spec }
CGOPackageSpec >> description [
	"package description: 'Pharo dependency management tool'"
	^ 'No description'
]

{ #category : #spec }
CGOPackageSpec >> file [
	^ self srcArtifact
]

{ #category : #initialization }
CGOPackageSpec >> initialize [
	super initialize.
	dictionary := Dictionary new
]

{ #category : #spec }
CGOPackageSpec >> name [
	self subclassResponsibility "^ 'Foo"
]

{ #category : #spec }
CGOPackageSpec >> packageName [
	^ self name
]

{ #category : #spec }
CGOPackageSpec >> packages [
	"package addSubPackage: 'Versionner-Spec-Browser'."
]

{ #category : #spec }
CGOPackageSpec >> platformRequirements [
	^ #()
]

{ #category : #spec }
CGOPackageSpec >> provisions [
	^ #()
]

{ #category : #spec }
CGOPackageSpec >> repositories [
	"^ #('http://smalltalkhub.com/mc/demarey/Versionner/main')"
	^ #()
	
" is overidern but this method is called by ongoing ..."
]

{ #category : #converting }
CGOPackageSpec >> sourcePackageVersionObject [
	| dict |
	[ dict := self sourcePackageVersion ]
	on: MessageNotUnderstood "src metadata not present"
	do: [ ^ nil ].
	^ ((dict at: #backend) = #monticello)
		ifTrue: [ CGOMonticelloHostedPackageVersion 
			repositoryUrl: (dict at: #repositoryUrl)
			packageName: (dict at: #packageName ifAbsent: [ self packageName ]) 
			versionString: (dict at: #versionString) ]
		ifFalse: [ CGOGitHostedPackageVersion 
			repositoryUrl: (dict at: #repositoryUrl)
			subdirectory: (dict at: #subdirectory)
			packageName: (dict at: #packageName ifAbsent: [ self packageName ])
			commitish: (dict at: #commitish) ]
]

{ #category : #spec }
CGOPackageSpec >> srcArtifact [
	^ 'no-file-specified-JohnDoe.0'
]

{ #category : #spec }
CGOPackageSpec >> testArtifact [
	self subclassResponsibility
]

{ #category : #spec }
CGOPackageSpec >> version [
	"package version: '0.1'"
]
