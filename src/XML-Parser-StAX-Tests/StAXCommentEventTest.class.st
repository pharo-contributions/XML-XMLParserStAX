Class {
	#name : #StAXCommentEventTest,
	#superclass : #StAXEventTest,
	#category : #'XML-Parser-StAX-Tests'
}

{ #category : #accessing }
StAXCommentEventTest >> eventClass [
	^ StAXCommentEvent
]

{ #category : #tests }
StAXCommentEventTest >> testIsComment [
	self assert: self newEvent isComment
]

{ #category : #tests }
StAXCommentEventTest >> testString [
	| comment |

	comment := self newEvent.
	self
		assert: comment string = '';
		assert: (comment string: 'test') == comment;
		assert: comment string = 'test'.

	comment := self eventClass string: 'test'.
	self
		assert: comment class == self eventClass;
		assert: comment string = 'test'.
]
