"
Example of a package specification.
"
Class {
	#name : #CGOExamplePackageSpec,
	#superclass : #CGOPackageSpec,
	#category : 'CargoPackageManager-Spec'
}

{ #category : #description }
CGOExamplePackageSpec >> authors [
	^ 'Demarey Christophe'
]

{ #category : #dependencies }
CGOExamplePackageSpec >> dependencies [
	^ { #spec -> #('=2.0') .
		#'spec-Platform' -> #('=2.0') .
		#ui -> #('=1.3') }

]

{ #category : #description }
CGOExamplePackageSpec >> description [
	^ 'An example of a Pharo package description'
]

{ #category : #description }
CGOExamplePackageSpec >> name [
	^ 'ExamplePackage'.
]

{ #category : #description }
CGOExamplePackageSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/demarey/Versionner/main')
]

{ #category : #accessing }
CGOExamplePackageSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/demarey/Versionner/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #description }
CGOExamplePackageSpec >> version [
	^ '0.1'.
]
