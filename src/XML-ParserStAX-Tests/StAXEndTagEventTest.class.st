"
Unit tests for StAXEndTagEvent
"
Class {
	#name : #StAXEndTagEventTest,
	#superclass : #StAXTagEventTest,
	#category : #'XML-ParserStAX-Tests-Events'
}

{ #category : #accessing }
StAXEndTagEventTest >> eventClass [
	^ StAXEndTagEvent
]

{ #category : #tests }
StAXEndTagEventTest >> testIsEndTag [
	self assert: self newEvent isEndTag
]

{ #category : #tests }
StAXEndTagEventTest >> testIsEndTagNamed [
	| tag |

	tag := self newEvent.
	self
		deny: (tag isEndTagNamed: 'one');
		deny: (tag isEndTagNamed: 'one:two').

	tag name: 'one'.
	self
		assert: (tag isEndTagNamed: 'one');
		deny: (tag isEndTagNamed: 'two').

	tag name: 'one:two'.
	self
		assert: (tag isEndTagNamed: 'two');
		assert: (tag isEndTagNamed: 'one:two');
		deny: (tag isEndTagNamed: 'one')
]

{ #category : #tests }
StAXEndTagEventTest >> testIsEndTagNamedAny [
	| tag |

	tag := self newEvent.
	self
		deny: (tag isEndTagNamedAny: #('two' 'one'));
		deny: (tag isEndTagNamedAny: #('two' 'one:two')).

	tag name: 'one'.
	self
		assert: (tag isEndTagNamedAny: #('one' 'two'));
		deny: (tag isEndTagNamedAny: #('one:two' 'two')).

	tag name: 'one:two'.
	self
		assert: (tag isEndTagNamedAny: #('two' 'one'));
		assert: (tag isEndTagNamedAny: #('two' 'one:two'));
		deny: (tag isEndTagNamedAny: #('one' 'two:one'))
]
