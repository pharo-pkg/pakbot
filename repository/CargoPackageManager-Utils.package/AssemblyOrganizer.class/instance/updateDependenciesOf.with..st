updating
updateDependenciesOf: ongoingPackageUnit with: anAssemblyManifest 
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