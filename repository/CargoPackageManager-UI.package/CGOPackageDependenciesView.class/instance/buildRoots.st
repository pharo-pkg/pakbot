private - building
buildRoots
	^ ongoingPackageVersion dependencies
		collect: [ :dependency | 
			TreeNodeModel new
				content: dependency;
				icon: self dependencyIcon yourself ]