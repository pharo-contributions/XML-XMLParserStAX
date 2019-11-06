"
Unit tests for StAXHTMLParser
"
Class {
	#name : #StAXHTMLParserTest,
	#superclass : #TestCase,
	#category : #'XML-ParserStAX-Tests-Parser'
}

{ #category : #asserting }
StAXHTMLParserTest >> assertIsSampleHTMLEvents: aCollection [
	| eventStream |

	eventStream := aCollection readStream.

	self assert: eventStream next isStartDocument.

	self
		assert: (eventStream next isStartTagNamed: 'html');
		assert: (eventStream next isStartTagNamed: 'body');
		assert: (eventStream next isStartTagNamed: 'b');
		assert: (eventStream peek isStartTagNamed: 'i');
		assert:
			eventStream next attributes =
				(XMLAttributeDictionary with: 'class' -> '&test;').

	self assert: (eventStream next isStringEvent: '< test & ').

	self
		assert: (eventStream next isEndTagNamed: 'i');
		assert: (eventStream next isEndTagNamed: 'b');
		assert: (eventStream next isEndTagNamed: 'body');
		assert: (eventStream next isEndTagNamed: 'html').

	self
		assert: eventStream next isEndDocument;
		assert: eventStream atEnd.
]

{ #category : #accessing }
StAXHTMLParserTest >> sampleHTML [
	^ '<b><i class="&test;">< test & '
]

{ #category : #tests }
StAXHTMLParserTest >> testHTMLParsing [
	StAXHTMLParser isSupported
		ifTrue: [
			self assertIsSampleHTMLEvents:
				(StAXHTMLParser parse: self sampleHTML)]
		ifFalse: [
			self
				should: [StAXHTMLParser parse: self sampleHTML]
				raise: Error]
]
