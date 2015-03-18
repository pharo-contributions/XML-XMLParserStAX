Class {
	#name : #StAXPIEventTest,
	#superclass : #StAXEventTest,
	#category : #'XML-Parser-StAX-Tests'
}

{ #category : #accessing }
StAXPIEventTest >> eventClass [
	^ StAXPIEvent
]

{ #category : #tests }
StAXPIEventTest >> testData [
	| pi |

	pi := self eventClass new.
	self assert: pi data isEmpty.
	pi data: 'test'.
	self assert: pi data = 'test'.
]

{ #category : #tests }
StAXPIEventTest >> testIsPI [
	self assert: self newEvent isPI
]

{ #category : #tests }
StAXPIEventTest >> testTarget [
	| pi |

	pi := self eventClass new.
	self assert: pi target isEmpty.
	pi target: 'test'.
	self assert: pi target = 'test'.
]
