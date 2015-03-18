Class {
	#name : #StAXStartTagEventTest,
	#superclass : #StAXTagEventTest,
	#category : #'XML-Parser-StAX-Tests'
}

{ #category : #accessing }
StAXStartTagEventTest >> eventClass [
	^ StAXStartTagEvent
]

{ #category : #tests }
StAXStartTagEventTest >> testIsStartTag [
	| tag |

	tag := self newEvent.
	self assert: self newEvent isStartTag.

	tag name: 'one'.
	self
		assert: (tag isStartTag: 'one');
		deny: (tag isStartTag: 'two').
]
