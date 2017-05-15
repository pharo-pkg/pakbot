private
buildRoots
	^ ongoingPackageVersion parts
		collect: [ :part | 
			TreeNodeModel new
				content: part;
				icon: (self iconForPackage: part);
				yourself ]