Class {
	#name : #StAXStartTagEventTest,
	#superclass : #StAXTagEventTest,
	#category : #'XML-ParserStAX-Tests'
}

{ #category : #accessing }
StAXStartTagEventTest >> eventClass [
	^ StAXStartTagEvent
]

{ #category : #tests }
StAXStartTagEventTest >> testIsStartTag [
	self assert: self newEvent isStartTag
]

{ #category : #tests }
StAXStartTagEventTest >> testIsStartTagNamed [
	| tag |

	tag := self newEvent.
	self
		deny: (tag isStartTagNamed: 'one');
		deny: (tag isStartTagNamed: 'one:two').

	tag name: 'one'.
	self
		assert: (tag isStartTagNamed: 'one');
		deny: (tag isStartTagNamed: 'two').

	tag name: 'one:two'.
	self
		assert: (tag isStartTagNamed: 'two');
		assert: (tag isStartTagNamed: 'one:two');
		deny: (tag isStartTagNamed: 'one').
]

{ #category : #tests }
StAXStartTagEventTest >> testIsStartTagNamedAny [
	| tag |

	tag := self newEvent.
	self
		deny: (tag isStartTagNamedAny: #('two' 'one'));
		deny: (tag isStartTagNamedAny: #('two' 'one:two')).

	tag name: 'one'.
	self
		assert: (tag isStartTagNamedAny: #('one' 'two'));
		deny: (tag isStartTagNamedAny: #('one:two' 'two')).

	tag name: 'one:two'.
	self
		assert: (tag isStartTagNamedAny: #('two' 'one'));
		assert: (tag isStartTagNamedAny: #('two' 'one:two'));
		deny: (tag isStartTagNamedAny: #('one' 'two:one')).
]
