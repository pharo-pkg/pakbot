Class {
	#name : #ManifestFoo,
	#superclass : #PackageManifest,
	#category : 'CargoPackageManager-Tests-FooResource'
}

{ #category : #'meta-data' }
ManifestFoo class >> dependencies [
	^ #(#'AST-Core' #Compression #Kernel #'Multilingual-TextConversion' #'Random-Core' #'System-Localization' #'System-Platforms' #'System-Settings' #'System-Sources' #Transcript)
]

{ #category : #'meta-data' }
ManifestFoo class >> description [
	^ 'I represent the manifest of a fake package. I''m used for test purposes.'
]

{ #category : #'meta-data' }
ManifestFoo class >> file [
	^ 'Kernel-TheIntegrator.2292'
]

{ #category : #'meta-data - dependency analyser' }
ManifestFoo class >> ignoredDependencies [
	^ #('Regex-Core' #'FFI-Kernel')
]

{ #category : #'meta-data - dependency analyser' }
ManifestFoo class >> manuallyResolvedDependencies [
	^ #(#'System-Settings' #'System-Sources' #'System-Localization' #'AST-Core' #Transcript #Compression #'Regex-Core' #'FFI-Kernel' #'Random-Core' #'System-Platforms' #'Multilingual-TextConversion')
]

{ #category : #'meta-data' }
ManifestFoo class >> packageName [
	^ #'CargoPackageManager-Tests-FooResource'
]

{ #category : #'meta-data' }
ManifestFoo class >> version [
	^ '1.0'
]
