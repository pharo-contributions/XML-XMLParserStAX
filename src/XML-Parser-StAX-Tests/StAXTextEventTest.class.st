Class {
	#name : #StAXTextEventTest,
	#superclass : #StAXEventTest,
	#category : #'XML-Parser-StAX-Tests'
}

{ #category : #accessing }
StAXTextEventTest >> eventClass [
	^ StAXTextEvent
]

{ #category : #tests }
StAXTextEventTest >> testIsEmpty [
	| event |

	event := self newEvent.
	self assert: event isEmpty.

	event := 'test'.
	self deny: event isEmpty.
]

{ #category : #tests }
StAXTextEventTest >> testIsText [
	| event |

	event := self newEvent.
	self
		assert: self newEvent isText;
		deny: (event isText: 'one').

	event string: 'one'.
	self
		assert: (event isText: 'one');
		deny: (event isText: 'two').
]

{ #category : #testing }
StAXTextEventTest >> testIsWhitespace [
	| event |

	event := self newEvent.
	self deny: event isWhitespace.

	event string: Character xmlWhitespace.
	self assert: event isWhitespace.

	event string: event string, 'non-space'.
	self deny: event isWhitespace.
]

{ #category : #tests }
StAXTextEventTest >> testNotEmpty [
	| event |

	event := self newEvent.
	self deny: event notEmpty.

	event := 'test'.
	self assert: event notEmpty.
]

{ #category : #tests }
StAXTextEventTest >> testString [
	| event |

	event := self newEvent.
	self
		assert: event string = '';
		assert: (event string: 'test') == event;
		assert: event string = 'test'.

	event := self eventClass string: 'test'.
	self
		assert: event class == self eventClass;
		assert: event string = 'test'.
]
