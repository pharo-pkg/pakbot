configuring
packages: packageNames 
	self manifests: (self manifestsFor: packageNames)
