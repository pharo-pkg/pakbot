public
get
	^ self response: (ZnResponse ok: (ZnEntity with: 'pong'))