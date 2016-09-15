comparing
hash
	^ (self class hash bitXor: targetedPackage hash) bitXor: packageVersion hash