"
Current version of avirtual  package  metadata. As a PackageVersion is not editable, it is the only way  to update it.
"
Class {
	#name : #PBVirtualPackage,
	#superclass : #PBProjectElement,
	#category : #'Pakbot-Minimal-Model'
}

{ #category : #example }
PBVirtualPackage class >> example [
	^ (self for: #'Virtual-Mail')
		description: 'I am a virtual package providing a mail functionality in version 1.0.
I provide the following API:
	msg = MimeMessage new.
	msg 
		from(''me@example.com'');
		recipients: #( ''you@example.com'' );
		setSubject(''Mail hello world example'');
		sentDate( DateAndTime now );
		text("Hello, world!").
	Transport send(msg, "me@example.com", "my-password").
';
		yourself
]
