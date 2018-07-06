private - building
buildRoots
	^ {1 .2. 3}
		collect: [ :dependency | 
			TreeNodeModel new
				content: dependency;
				icon: self unitIcon"(self iconForPackage: dependency)" ]