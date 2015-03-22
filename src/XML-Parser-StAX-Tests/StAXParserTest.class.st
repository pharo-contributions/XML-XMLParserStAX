Class {
	#name : #StAXParserTest,
	#superclass : #TestCase,
	#category : #'XML-Parser-StAX-Tests'
}

{ #category : #asserting }
StAXParserTest >> assertIsSampleNamespaceXMLEvents: aCollection [
	| eventStream |

	eventStream := aCollection readStream.

	self assert: eventStream next isStartDocument.

	self
		assert: (eventStream peek isStartTag: 'one');
		assert: eventStream peek namespaceURI isEmpty;
		assert: eventStream peek hasAttributes;
		assert:
			eventStream next attributes asDictionary =
				(Dictionary with: 'a' -> '1' with: 'b' -> '2').

	self
		assert: (eventStream peek isStartTag: 'two');
		assert: eventStream peek namespaceURI = 'defaultNS';
		deny: eventStream next hasAttributes;
		assert: eventStream peek isComment;
		assert: eventStream next string = 'comment'.

	self
		assert: (eventStream peek isStartTag: 'three');
		assert: (eventStream peek isStartTag: 'prefix:three');
		assert: eventStream peek namespaceURI = 'prefixNS';
		deny: eventStream next hasAttributes;
		assert: eventStream peek isPI;
		assert: eventStream peek target = 'target';
		assert: eventStream next data = 'data';
		assert: (eventStream peek isEndTag: 'three');
		assert: (eventStream next isEndTag: 'prefix:three').
	self assert: (eventStream next isEndTag: 'two').

	self
		assert: (eventStream peek isStartTag: 'four');
		assert: eventStream peek namespaceURI isEmpty;
		deny: eventStream next hasAttributes;
		assert: (eventStream next isText: 'text');
		assert: (eventStream next isEndTag: 'four').

	self
		assert: (eventStream peek isStartTag: 'five');
		assert: eventStream peek namespaceURI isEmpty;
		deny: eventStream next hasAttributes;
		assert: (eventStream next isText: 'before ');
		assert: eventStream peek isCData;
		assert: (eventStream next isText: 'cdata text');
		assert: (eventStream next isText: ' after');
		assert: (eventStream next isEndTag: 'five').

	self
		assert: (eventStream peek isStartTag: 'six');
		assert: eventStream peek namespaceURI isEmpty;
		deny: eventStream next hasAttributes;
		assert: (eventStream next isEndTag: 'six').

	self assert: (eventStream next isEndTag: 'one').

	self
		assert: eventStream next isEndDocument;
		assert: eventStream atEnd.
]

{ #category : #asserting }
StAXParserTest >> assertIsSampleXMLEvents: aCollection [
	| eventStream |

	eventStream := aCollection readStream.

	self assert: eventStream next isStartDocument.

	self
		assert: (eventStream peek isStartTag: 'one');
		assert: eventStream peek namespaceURI isEmpty;
		assert: eventStream peek hasAttributes;
		assert:
			eventStream next attributes asDictionary =
				(Dictionary with: 'a' -> '1' with: 'b' -> '2').

	self
		assert: (eventStream peek isStartTag: 'two');
		assert: eventStream peek namespaceURI isEmpty;
		deny: eventStream next hasAttributes;
		assert: eventStream peek isComment;
		assert: eventStream next string = 'comment'.

	self
		assert: (eventStream peek isStartTag: 'three');
		assert: eventStream peek namespaceURI isEmpty;
		deny: eventStream next hasAttributes;
		assert: eventStream peek isPI;
		assert: eventStream peek target = 'target';
		assert: eventStream next data = 'data';
		assert: (eventStream next isEndTag: 'three').
	self assert: (eventStream next isEndTag: 'two').

	self
		assert: (eventStream peek isStartTag: 'four');
		assert: eventStream peek namespaceURI isEmpty;
		deny: eventStream next hasAttributes;
		assert: (eventStream next isText: 'text');
		assert: (eventStream next isEndTag: 'four').

	self
		assert: (eventStream peek isStartTag: 'five');
		assert: eventStream peek namespaceURI isEmpty;
		deny: eventStream next hasAttributes;
		assert: (eventStream next isText: 'before ');
		assert: eventStream peek isCData;
		assert: (eventStream next isText: 'cdata text');
		assert: (eventStream next isText: ' after');
		assert: (eventStream next isEndTag: 'five').

	self
		assert: (eventStream peek isStartTag: 'six');
		assert: eventStream peek namespaceURI isEmpty;
		deny: eventStream next hasAttributes;
		assert: (eventStream next isEndTag: 'six').

	self assert: (eventStream next isEndTag: 'one').

	self
		assert: eventStream next isEndDocument;
		assert: eventStream atEnd.
]

{ #category : #accessing }
StAXParserTest >> sampleNamespaceXML [
	^ '
	<?xml version="1.0" encoding="UTF-8"?>
	<one a="1" b="2">
		<two xmlns="defaultNS" xmlns:prefix="prefixNS">
			<!--comment-->
			<prefix:three><?target data?></prefix:three>
		</two>
		<four>text</four>
		<five>before <![CDATA[cdata text]]> after</five>
		<six />
	</one>
	'
]

{ #category : #accessing }
StAXParserTest >> sampleXML [
	^ '
	<?xml version="1.0" encoding="UTF-8"?>
	<one a="1" b="2">
		<two>
			<!--comment-->
			<three><?target data?></three>
		</two>
		<four>text</four>
		<five>before <![CDATA[cdata text]]> after</five>
		<six />
	</one>
	'
]

{ #category : #tests }
StAXParserTest >> testAsDOM [
	| node |

	node := (StAXParser on: self sampleXML) upToEnd asDOM.
	self
		assert: node isDocument;
		assert:
			node allElements elementNames asArray =
				#('one' 'two' 'three' 'four' 'five' 'six').

	node := (StAXParser on: self sampleXML) upToEnd allButFirst asDOM.
	self
		assert: (node isElementNamed: 'one');
		assert:
			node allElements elementNames asArray =
				#('one' 'two' 'three' 'four' 'five' 'six').
]

{ #category : #tests }
StAXParserTest >> testCurrent [
	| parser events |

	parser := StAXParser on: self sampleXML.
	self assert: parser current isInitialEvent.
	events := OrderedCollection new.
	[parser atEnd]
		whileFalse: [
			parser next.
			events addLast: parser current].
	self assertIsSampleXMLEvents: events.

	self assert: parser current isEndDocument.
]

{ #category : #tests }
StAXParserTest >> testDo [
	| events |

	events := OrderedCollection new.
	(StAXParser on: self sampleXML) do: [:each | events add: each].
	self assertIsSampleXMLEvents: events.
]

{ #category : #tests }
StAXParserTest >> testNamespaceParsing [
	self assertIsSampleNamespaceXMLEvents:
		(StAXParser on: self sampleNamespaceXML) upToEnd.
]

{ #category : #tests }
StAXParserTest >> testNext [
	| parser events |

	parser := StAXParser on: self sampleXML.
	events := OrderedCollection new.
	[parser atEnd]
		whileFalse: [events addLast: parser next].
	self assertIsSampleXMLEvents: events.

	"subsequent calls return end document events"
	self assert: parser next isEndDocument.

	parser := StAXParser on: self sampleXML.
	self assertIsSampleXMLEvents: (parser next: events size).
	self assert: (parser next: events size) isEmpty.
]

{ #category : #tests }
StAXParserTest >> testNextDOM [
	| parser element |

	parser := StAXParser on: self sampleXML.
	parser
		skipUntil: [parser peek isStartTag: 'two'].
	element := parser nextDOM.
	self
		assert: (element isElementNamed: 'two');
		assert: element nodes size = 2;
		assert: element nodes first isComment;
		assert: (element nodes second isElementNamed: 'three').
	self assert: (parser next isStartTag: 'four').

	parser upToEnd.
	self assert: parser nextDOM isNil.
]

{ #category : #tests }
StAXParserTest >> testNextUntil [
	| parser |

	parser := StAXParser on: self sampleXML.
	self assertIsSampleXMLEvents: (parser nextUntil: [parser atEnd]).
	self
		assert: (parser nextUntil: [false]) isEmpty;
		assert: (parser nextUntil: [true]) isEmpty.
]

{ #category : #tests }
StAXParserTest >> testNextWhile [
	| parser |

	parser := StAXParser on: self sampleXML.
	self assertIsSampleXMLEvents: (parser nextWhile: [parser atEnd not]).
	self
		assert: (parser nextWhile: [false]) isEmpty;
		assert: (parser nextWhile: [true]) isEmpty.
]

{ #category : #tests }
StAXParserTest >> testParseDocument [
	self assertIsSampleXMLEvents: (StAXParser on: self sampleXML) parseDocument
]

{ #category : #tests }
StAXParserTest >> testPeek [
	| parser events |

	parser := StAXParser on: self sampleXML.
	events := OrderedCollection new.
	[parser atEnd]
		whileFalse: [
			events addLast: parser peek.
			parser next].
	self assertIsSampleXMLEvents: events.

	"subsequent calls return end document events"
	self assert: parser peek isEndDocument.
]

{ #category : #tests }
StAXParserTest >> testPeekRepeating [
	| parser events |

	parser := StAXParser on: self sampleXML.
	events := OrderedCollection new.
	[parser atEnd]
		whileFalse: [| nextEvent |
			nextEvent := parser peek.
			self assert: parser peek == nextEvent.
			events addLast: nextEvent.
			parser next].
	self assertIsSampleXMLEvents: events.

	"subsequent calls return end document events"
	self assert: parser peek isEndDocument.
]

{ #category : #tests }
StAXParserTest >> testSelect [
	| parser |

	parser := StAXParser on: self sampleXML.
	self assert:
		((parser select: [:each | each isStartTag]) collect: [:each | each name]) asArray = 
			#('one' 'two' 'three' 'four' 'five' 'six').
]

{ #category : #tests }
StAXParserTest >> testSkip [
	| events parser |

	events :=
		((StAXParser on: self sampleXML) next: 5),
		((StAXParser on: self sampleXML)
			skip: 5;
			upToEnd).
	self assertIsSampleXMLEvents: events.

	(parser := StAXParser on: self sampleXML)
		skip: events size - 1.
	self deny: parser atEnd.
	parser skip: 1.
	self assert: parser atEnd.
	parser skip: events size.
	self assert: parser atEnd.
]

{ #category : #tests }
StAXParserTest >> testSkipsCDataEvents [
	| xml parser |

	xml := '
		<?xml version="1.0"?>
		<test>
			<![CDATA[cdata text]]>
		</test>'.
	parser := StAXParser on: xml.
	parser next: 2.
	self
		assert: parser peek isCData;
		assert: (parser next isText: 'cdata text').

	(parser := StAXParser on: xml)
		skipsCDataEvents: false;
		next: 2.
	self
		assert: parser peek isCData;
		assert: (parser next isText: 'cdata text').

	(parser := StAXParser on: xml)
		skipsCDataEvents: true;
		next: 2.
	self
		deny: parser peek isCData;
		assert: (parser next isText: 'cdata text').
]

{ #category : #tests }
StAXParserTest >> testSkipsCommentEvents [
	| xml parser |

	xml := '
		<?xml version="1.0"?>
		<test>
			<!--comment-->
		</test>'.
	parser := StAXParser on: xml.
	parser next: 2.
	self assert: parser next isComment.

	(parser := StAXParser on: xml)
		skipsCommentEvents: false;
		next: 2.
	self assert: parser next isComment.

	(parser := StAXParser on: xml)
		skipsCommentEvents: true;
		next: 2.
	self deny: parser next isComment.
]

{ #category : #tests }
StAXParserTest >> testSkipsPIEvents [
	| xml parser |

	xml := '
		<?xml version="1.0"?>
		<test>
			<?target data?>
		</test>'.
	parser := StAXParser on: xml.
	parser next: 2.
	self assert: parser next isPI.

	(parser := StAXParser on: xml)
		skipsPIEvents: false;
		next: 2.
	self assert: parser next isPI.

	(parser := StAXParser on: xml)
		skipsPIEvents: true;
		next: 2.
	self deny: parser next isPI.
]

{ #category : #tests }
StAXParserTest >> testUpToEnd [
	self assertIsSampleXMLEvents: (StAXParser on: self sampleXML) upToEnd
]

{ #category : #tests }
StAXParserTest >> testWriteEvents [
	self assert:
		(XMLWriter writeWith: [:writer |
			writer writeEvents: (StAXParser on: self sampleXML) upToEnd]) =
				((XMLDOMParser on: self sampleXML)
					preservesCommentNodes: true;
					preservesCDataNodes: true;
					parseDocument) root printString
]
