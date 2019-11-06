"
Unit tests for StAXStringEvent
"
Class {
	#name : #StAXStringEventTest,
	#superclass : #StAXEventTest,
	#category : #'XML-ParserStAX-Tests-Events'
}

{ #category : #accessing }
StAXStringEventTest >> eventClass [
	^ StAXStringEvent
]

{ #category : #tests }
StAXStringEventTest >> testAsString [
	| event |

	event := self newEvent.
	self assert: event asString equals: ''.

	event string: 'test'.
	self assert: event asString equals: 'test'
]

{ #category : #tests }
StAXStringEventTest >> testIsEmpty [
	| event |

	event := self newEvent.
	self assert: event isEmpty.

	event string: 'test'.
	self deny: event isEmpty
]

{ #category : #tests }
StAXStringEventTest >> testIsStringEvent [
	| event |

	event := self newEvent.
	self
		assert: self newEvent isStringEvent;
		deny: (event isStringEvent: 'one');
		deny: (event isStringEvent: 'two').

	event string: 'one'.
	self
		assert: (event isStringEvent: 'one');
		deny: (event isStringEvent: 'two').

	event string: 'two'.
	self
		deny: (event isStringEvent: 'one');
		assert: (event isStringEvent: 'two')
]

{ #category : #testing }
StAXStringEventTest >> testIsWhitespace [
	| event |

	event := self newEvent.
	self deny: event isWhitespace.

	event string: Character xmlWhitespace.
	self assert: event isWhitespace.

	event string: event string, 'non-space'.
	self deny: event isWhitespace
]

{ #category : #tests }
StAXStringEventTest >> testNotEmpty [
	| event |

	event := self newEvent.
	self deny: event notEmpty.

	event string: 'test'.
	self assert: event notEmpty
]

{ #category : #tests }
StAXStringEventTest >> testString [
	| event |

	event := self newEvent.
	self
		assert: event string equals: '';
		assert: (event string: 'test') == event;
		assert: event string equals: 'test'.

	event := self eventClass string: 'test'.
	self
		assert: event class == self eventClass;
		assert: event string equals: 'test'
]
