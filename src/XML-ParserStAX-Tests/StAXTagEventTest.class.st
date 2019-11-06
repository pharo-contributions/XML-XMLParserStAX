"
Unit tests for StAXTagEvent and subclasses
"
Class {
	#name : #StAXTagEventTest,
	#superclass : #StAXEventTest,
	#category : #'XML-ParserStAX-Tests-Events'
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
		assert: tag localName equals: '';
		assert: (tag name: 'one') == tag;
		assert: tag localName equals: 'one';
		assert: (tag name: 'one:two') == tag;
		assert: tag localName equals: 'two'
]

{ #category : #tests }
StAXTagEventTest >> testName [
	| tag |

	tag := self newEvent.
	self
		assert: tag name equals: '';
		assert: (tag name: 'one') == tag;
		assert: tag name equals: 'one';
		assert: (tag name: 'one:two') == tag;
		assert: tag name equals: 'one:two'
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
		assert: tag name equals: 'prefix:test';
		assert: tag localName equals: 'test';
		assert: tag prefix equals: 'prefix';
		assert: tag namespaceURI equals: 'testNS'
]

{ #category : #tests }
StAXTagEventTest >> testNamed [
	| tag |

	tag := self eventClass named: 'test'.
	self
		assert: tag class == self eventClass;
		assert: tag name equals: 'test'
]

{ #category : #tests }
StAXTagEventTest >> testNamespaceURI [
	| tag |

	tag := self newEvent.
	self assert: self newEvent namespaceURI equals: ''.

	tag
		setName: 'test'
		namespaceURI: 'testNS'.
	self assert: tag namespaceURI equals: 'testNS'
]

{ #category : #tests }
StAXTagEventTest >> testPrefix [
	| tag |

	tag := self newEvent.
	self assert: tag prefix equals: ''.

	tag name: 'one'.
	self assert: tag prefix equals: ''.

	tag name: 'one:two'.
	self assert: tag prefix equals: 'one'
]
