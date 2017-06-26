accessing
smalltalkVendor
	^ tags
		at: self class smalltalkVendorTag 
		ifAbsent: [ nil ]