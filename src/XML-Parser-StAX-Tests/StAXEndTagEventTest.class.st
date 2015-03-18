Class {
	#name : #StAXEndTagEventTest,
	#superclass : #StAXTagEventTest,
	#category : #'XML-Parser-StAX-Tests'
}

{ #category : #accessing }
StAXEndTagEventTest >> eventClass [
	^ StAXEndTagEvent
]

{ #category : #tests }
StAXEndTagEventTest >> testIsEndTag [
	| tag |

	tag := self newEvent.
	self assert: self newEvent isEndTag.

	tag name: 'one'.
	self
		assert: (tag isEndTag: 'one');
		deny: (tag isEndTag: 'two').
]
