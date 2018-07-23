Class {
	#name : #AssemblyOrganizer,
	#superclass : #Object,
	#category : 'CargoPackageManager-Utils'
}

{ #category : #checking }
AssemblyOrganizer class >> check: aPackageName [
	self new
		check: aPackageName
]

{ #category : #accessing }
AssemblyOrganizer >> assemblies [
	^ AssemblyManifest allSubclasses
]

{ #category : #checking }
AssemblyOrganizer >> check: aPackageName [
	| ongoing assemblies |
	ongoing := PBPackage on: (RPackage named: aPackageName) packageManifest.
	assemblies := self assemblies
		select: [ :assembly | assembly includesAny: (ongoing dependencies collect: #packageName) ]
		thenDo: [ :assembly | self updateDependenciesOf: ongoing with: assembly ]
]

{ #category : #updating }
AssemblyOrganizer >> updateDependenciesOf: ongoingPackageUnit with: anAssemblyManifest [ 
	| dependenciesToRemove message |
	dependenciesToRemove := ongoingPackageUnit dependencies
		select: [ :dependency | anAssemblyManifest includes: dependency packageName ].
	message := String streamContents: [ :stream | 
		stream 
			nextPutAll: 'Replace ';
			cr;
			nextPutAll: (Character cr join: dependenciesToRemove);
			cr;
			nextPutAll: ' with ';
			cr;
			nextPutAll: anAssemblyManifest packageName;
			nextPut: $? ].
	(UIManager default confirm: message)
		ifTrue: [ ongoingPackageUnit addDependencyOn: anAssemblyManifest packageName.
			dependenciesToRemove do: [:each | ongoingPackageUnit removeDependency: each] ]
]
