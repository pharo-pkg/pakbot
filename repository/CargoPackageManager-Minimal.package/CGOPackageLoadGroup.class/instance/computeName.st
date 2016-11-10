private
computeName
	name := ', ' join: (packageVersionRefs collect: #packageName)