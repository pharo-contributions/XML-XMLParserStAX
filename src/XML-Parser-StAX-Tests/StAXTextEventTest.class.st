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
	self
		assert: self newEvent isText;
		assert: ((self eventClass string: 'one') isText: 'one');
		deny: ((self eventClass string: 'one') isText: 'two')
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
	| text |

	text := self eventClass new.
	self assert: text string isEmpty.
	text string: 'test'.
	self assert: text string = 'test'.

	self assert: (self eventClass string: 'test') string = 'test'.
]
