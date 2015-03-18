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
		assert: (tag isNamed: 'one:two').
]

{ #category : #tests }
StAXTagEventTest >> testIsTag [
	self assert: self newEvent isTag
]

{ #category : #tests }
StAXTagEventTest >> testLocalName [
	| tag |

	tag := self newEvent.
	self assert: tag localName isEmpty.

	tag name: 'one'.
	self assert: tag localName = 'one'.

	tag name: 'one:two'.
	self assert: tag localName = 'two'.
]

{ #category : #tests }
StAXTagEventTest >> testName [
	| tag |

	tag := self newEvent.
	self assert: tag name isEmpty.

	tag name: 'one'.
	self assert: tag name = 'one'.

	tag name: 'one:two'.
	self assert: tag name = 'one:two'.
]

{ #category : #tests }
StAXTagEventTest >> testNamespaceURI [
	self
		assert: self newEvent namespaceURI isEmpty;
		assert:
			(self eventClass
				name: ''
				localName: ''
				namespaceURI: 'test') namespaceURI = 'test'
]

{ #category : #tests }
StAXTagEventTest >> testPrefix [
	| tag |

	tag := self newEvent.
	self assert: tag prefix isEmpty.

	tag name: 'one'.
	self assert: tag prefix isEmpty.

	tag name: 'one:two'.
	self assert: tag prefix = 'one'.
]