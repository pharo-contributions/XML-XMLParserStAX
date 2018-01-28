Class {
	#name : #StAXPIEventTest,
	#superclass : #StAXEventTest,
	#category : #'XML-ParserStAX-Tests'
}

{ #category : #accessing }
StAXPIEventTest >> eventClass [
	^ StAXPIEvent
]

{ #category : #tests }
StAXPIEventTest >> testData [
	| pi |

	pi := self newEvent.
	self
		assert: pi data = '';
		assert: (pi data: 'test') == pi;
		assert: pi data = 'test'.
]

{ #category : #tests }
StAXPIEventTest >> testIsPI [
	self assert: self newEvent isPI
]

{ #category : #tests }
StAXPIEventTest >> testTarget [
	| pi |

	pi := self newEvent.
	self
		assert: pi target = '';
		assert: (pi target: 'test') == pi;
		assert: pi target = 'test'.
]

{ #category : #tests }
StAXPIEventTest >> testTargetData [
	| pi |

	pi :=
		self eventClass
			target: 'target'
			data: 'data'.
	self
		assert: pi class == self eventClass;
		assert: pi target = 'target';
		assert: pi data = 'data'.
]
