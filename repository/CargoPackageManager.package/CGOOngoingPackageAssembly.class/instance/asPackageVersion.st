converting
asPackageVersion
	^ CGOPackageVersion newFrom: 
		( Dictionary new
			add: #package -> self packageName asSymbol;
			add: #version -> self version;
			add: #parts -> (self parts collect: #asLiteral);
			add: #description -> self description;
			add: #timestamp -> DateAndTime now;
			yourself )