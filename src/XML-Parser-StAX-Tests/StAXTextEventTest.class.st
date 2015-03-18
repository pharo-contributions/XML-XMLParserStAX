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
StAXTextEventTest >> testIsText [
	self
		assert: self newEvent isText;
		assert: ((self eventClass string: 'one') isText: 'one');
		deny: ((self eventClass string: 'one') isText: 'two')
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
