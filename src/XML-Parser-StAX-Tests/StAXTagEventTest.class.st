Class {
	#name : #StAXTagEventTest,
	#superclass : #StAXEventTest,
	#category : #'XML-Parser-StAX-Tests'
}

{ #category : #accessing }
StAXTagEventTest >> eventClass [
	^ StAXTagEvent
]

{ #category : #tests }
StAXTagEventTest >> testIsNamed [
	| tag |

	tag := self newEvent.
	self
		deny: (tag isNamed: 'one');
		deny: (tag isNamed: 'one:two').

	tag name: 'one'.
	self
		assert: (tag isNamed: 'one');
		deny: (tag isNamed: 'one:two').

	tag name: 'one:two'.
	self
		assert: (tag isNamed: 'two');
		assert: (tag isNamed: 'one:two');
		deny: (tag isNamed: 'one').
]

{ #category : #tests }
StAXTagEventTest >> testIsNamedAny [
	| tag |

	tag := self newEvent.
	self
		deny: (tag isNamedAny: #('two' 'one') asSet);
		deny: (tag isNamedAny: #('two' 'one:two') asSet).

	tag name: 'one'.
	self
		assert: (tag isNamedAny: #('two' 'one'));
		deny: (tag isNamedAny: #('two' 'one:two')).

	tag name: 'one:two'.
	self
		assert: (tag isNamedAny: #('two' 'one'));
		assert: (tag isNamedAny: #('two' 'one:two'));
		deny: (tag isNamedAny: #('one' 'two:one')).
]

{ #category : #tests }
StAXTagEventTest >> testIsTag [
	self assert: self newEvent isTag
]

{ #category : #tests }
StAXTagEventTest >> testLocalName [
	| tag |

	tag := self newEvent.
	self
		assert: tag localName = '';
		assert: (tag name: 'one') == tag;
		assert: tag localName = 'one';
		assert: (tag name: 'one:two') == tag;
		assert: tag localName = 'two'.
]

{ #category : #tests }
StAXTagEventTest >> testName [
	| tag |

	tag := self newEvent.
	self
		assert: tag name = '';
		assert: (tag name: 'one') == tag;
		assert: tag name = 'one';
		assert: (tag name: 'one:two') == tag;
		assert: tag name = 'one:two'.
]

{ #category : #tests }
StAXTagEventTest >> testNameNamespaceURI [
	| tag |

	tag :=
		self eventClass
			name: 'prefix:test'
			namespaceURI: 'testNS'.
	self
		assert: tag class == self eventClass;
		assert: tag name = 'prefix:test';
		assert: tag localName = 'test';
		assert: tag prefix = 'prefix';
		assert: tag namespaceURI = 'testNS'.
]

{ #category : #tests }
StAXTagEventTest >> testNamed [
	| tag |

	tag := self eventClass named: 'test'.
	self
		assert: tag class == self eventClass;
		assert: tag name = 'test'.
]

{ #category : #tests }
StAXTagEventTest >> testNamespaceURI [
	| tag |

	tag := self newEvent.
	self assert: self newEvent namespaceURI = ''.

	tag
		setName: 'test'
		namespaceURI: 'testNS'.
	self assert: tag namespaceURI = 'testNS'.
]

{ #category : #tests }
StAXTagEventTest >> testPrefix [
	| tag |

	tag := self newEvent.
	self assert: tag prefix = ''.

	tag name: 'one'.
	self assert: tag prefix = ''.

	tag name: 'one:two'.
	self assert: tag prefix = 'one'.
]
