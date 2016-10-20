parsing
consumeColon
	[ readStream atEnd not and: [ readStream peek isSeparator or: [ readStream peek = $: ] ] ]
		whileTrue: [ readStream next ]
