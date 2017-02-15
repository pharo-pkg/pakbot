example
example
	^ self newFrom:
	 	( Dictionary new
			add: #package -> #Mail;
			add: #version -> '1.0' asSemanticVersion;
			add: #description -> 'I respect the mail protocol V1.0. See link for more details.';
			yourself ).