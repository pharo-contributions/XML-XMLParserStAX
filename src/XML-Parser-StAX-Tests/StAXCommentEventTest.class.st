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

	comment := self eventClass new.
	self assert: comment string isEmpty.
	comment string: 'test'.
	self assert: comment string = 'test'.

	self assert: (self eventClass string: 'test') string = 'test'.
]
