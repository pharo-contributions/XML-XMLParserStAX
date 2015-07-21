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
		assert: (eventStream peek isStartTagNamed: 'one');
		assert: eventStream peek namespaceURI isEmpty;
		assert: eventStream peek hasAttributes;
		assert:
			eventStream next attributes =
				(OrderPreservingStringDictionary with: 'a' -> '1' with: 'b' -> '2').

	self
		assert: (eventStream peek isStartTagNamed: 'two');
		assert: eventStream peek namespaceURI = 'defaultNS';
		deny: eventStream next hasAttributes.

	self
		assert: (eventStream peek isStartTagNamed: 'three');
		assert: (eventStream peek isStartTagNamed: 'prefix:three');
		assert: eventStream peek namespaceURI = 'prefixNS';
		deny: eventStream next hasAttributes;
		assert: eventStream peek isPI;
		assert: eventStream peek target = 'target';
		assert: eventStream next data = 'data';
		assert: (eventStream peek isEndTagNamed: 'three');
		assert: (eventStream next isEndTagNamed: 'prefix:three').
	self assert: (eventStream next isEndTagNamed: 'two').

	self
		assert: (eventStream peek isStartTagNamed: 'four');
		assert: eventStream peek namespaceURI isEmpty;
		deny: eventStream next hasAttributes;
		assert: (eventStream next isText: 'text');
		assert: (eventStream next isEndTagNamed: 'four').

	self
		assert: (eventStream peek isStartTagNamed: 'five');
		assert: eventStream peek namespaceURI isEmpty;
		deny: eventStream next hasAttributes;
		assert: (eventStream next isText: 'before ');
		deny: eventStream peek isCData;
		assert: (eventStream next isText: 'cdata text');
		assert: (eventStream next isText: ' after');
		assert: (eventStream next isEndTagNamed: 'five').

	self
		assert: (eventStream peek isStartTagNamed: 'six');
		assert: eventStream peek namespaceURI isEmpty;
		deny: eventStream next hasAttributes;
		assert: (eventStream next isEndTagNamed: 'six').

	self assert: (eventStream next isEndTagNamed: 'one').

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
		assert: (eventStream peek isStartTagNamed: 'one');
		assert: eventStream peek namespaceURI isEmpty;
		assert: eventStream peek hasAttributes;
		assert:
			eventStream next attributes =
				(OrderPreservingStringDictionary with: 'a' -> '1' with: 'b' -> '2').

	self
		assert: (eventStream peek isStartTagNamed: 'two');
		assert: eventStream peek namespaceURI isEmpty;
		deny: eventStream next hasAttributes.

	self
		assert: (eventStream peek isStartTagNamed: 'three');
		assert: eventStream peek namespaceURI isEmpty;
		deny: eventStream next hasAttributes;
		assert: eventStream peek isPI;
		assert: eventStream peek target = 'target';
		assert: eventStream next data = 'data';
		assert: (eventStream next isEndTagNamed: 'three').
	self assert: (eventStream next isEndTagNamed: 'two').

	self
		assert: (eventStream peek isStartTagNamed: 'four');
		assert: eventStream peek namespaceURI isEmpty;
		deny: eventStream next hasAttributes;
		assert: (eventStream next isText: 'text');
		assert: (eventStream next isEndTagNamed: 'four').

	self
		assert: (eventStream peek isStartTagNamed: 'five');
		assert: eventStream peek namespaceURI isEmpty;
		deny: eventStream next hasAttributes;
		assert: (eventStream next isText: 'before ');
		deny: eventStream peek isCData;
		assert: (eventStream next isText: 'cdata text');
		assert: (eventStream next isText: ' after');
		assert: (eventStream next isEndTagNamed: 'five').

	self
		assert: (eventStream peek isStartTagNamed: 'six');
		assert: eventStream peek namespaceURI isEmpty;
		deny: eventStream next hasAttributes;
		assert: (eventStream next isEndTagNamed: 'six').

	self assert: (eventStream next isEndTagNamed: 'one').

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
StAXParserTest >> testAsNode [
	| node |

	node := (StAXParser on: self sampleXML) upToEnd asNode.
	self
		assert: node isDocument;
		assert:
			node allElements elementNames asArray =
				#('one' 'two' 'three' 'four' 'five' 'six').

	node := (StAXParser on: self sampleXML) upToEnd allButFirst asNode.
	self
		assert: (node isElementNamed: 'one');
		assert:
			node allElements elementNames asArray =
				#('one' 'two' 'three' 'four' 'five' 'six').
]

{ #category : #tests }
StAXParserTest >> testAsNodeConfigurationInheritance [
	| parser |

	parser := StAXParser on: self sampleXML.
	self assert:
		parser upToEnd asNode configuration ==
			parser configuration domConfiguration.
]

{ #category : #tests }
StAXParserTest >> testCollect [
	| parser pairs |

	parser := StAXParser on: self sampleXML.
	pairs := parser collect: [:each | each -> each identityHash].
	self
		assert: pairs class == XMLOrderedList;
		assert: (pairs allSatisfy: [:each | each isKindOf: Association]);
		assertIsSampleXMLEvents: (pairs collect: [:each | each key]).
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
StAXParserTest >> testDetect [
	| parser |

	parser := StAXParser on: self sampleXML.
	self
		assert: ((parser detect: [:each | each isStartTagNamed: 'two']) isStartTagNamed: 'two');
		assert: (parser detect: [:each | each isStartTagNamed: 'two']) isNil.
]

{ #category : #tests }
StAXParserTest >> testDetectIfNone [
	| parser |

	parser := StAXParser on: self sampleXML.
	self assert:
		((parser
			detect: [:each | each isStartTagNamed: 'two']
			ifNone: [#absent]) isStartTagNamed: 'two').
	self assert:
		(parser
			detect: [:each | each isStartTagNamed: 'two']
			ifNone: [#absent]) = #absent.
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
StAXParserTest >> testNextElement [
	| parser elements nextElement |

	parser := StAXParser on: self sampleXML.
	self
		assert: (parser nextElement isElementNamed: 'one');
		assert: parser nextElement isNil;
		assert: parser atEnd.

	(parser := StAXParser on: self sampleXML)
		skipUntil: [parser current isStartTagNamed: 'one'].
	elements := OrderedCollection new.
	[parser atEnd
		or: [(nextElement := parser nextElement) isNil]]
		whileFalse: [elements addLast: nextElement].

	self
		assert: (elements allSatisfy: [:each | each isElement]);
		assert: (elements collect: [:each | each name]) asArray = #('two' 'four' 'five' 'six');
		assert: parser atEnd.
]

{ #category : #tests }
StAXParserTest >> testNextElementNamed [
	| parser |

	parser := StAXParser on: self sampleXML.
	self
		assert: ((parser nextElementNamed: 'two') isElementNamed: 'two');
		assert: (parser peek isStartTagNamed: 'four');
		assert: ((parser nextElementNamed: 'five') isElementNamed: 'five');
		assert: (parser peek isStartTagNamed: 'six');
		assert: (parser nextElementNamed: 'five') isNil;
		assert: parser atEnd.
]

{ #category : #tests }
StAXParserTest >> testNextElementNamedNamespaceURI [
	| parser |

	parser := StAXParser on: self sampleNamespaceXML.
	self
		assert: ((parser nextElementNamed: 'three' namespaceURI: 'prefixNS') isElementNamed: 'three');
		assert: (parser peek isEndTagNamed: 'two');
		assert: (parser nextElementNamed: 'four' namespaceURI: 'prefixNS') isNil;
		assert: parser atEnd.
]

{ #category : #tests }
StAXParserTest >> testNextNode [
	| parser element |

	(parser := StAXParser on: self sampleXML)
		skipUntil: [parser peek isStartTagNamed: 'two'].
	element := parser nextNode.
	self
		assert: (element isElementNamed: 'two');
		assert: element nodes size = 1;
		assert: (element nodes first isElementNamed: 'three').
	self
		assert: (parser next isStartTagNamed: 'four');
		assert: (parser nextNode isStringNode: 'text').

	element := parser nextNode.
	self
		assert: (element isElementNamed: 'five');
		assert: (element nodes allSatisfy: [:each | each isStringNode]).
	self assert: (parser next isStartTagNamed: 'six').

	parser upToEnd.
	self assert: parser nextNode isNil.
]

{ #category : #tests }
StAXParserTest >> testNextNodeConfigurationInheritance [
	| parser |

	parser := StAXParser on: self sampleXML.
	self assert:
		parser nextNode configuration ==
			parser configuration domConfiguration.
]

{ #category : #tests }
StAXParserTest >> testNextNodeElements [
	| parser elements |

	parser := StAXParser on: self sampleXML.
	elements := OrderedCollection new.
	parser skipUntil: [parser current isStartTagNamed: 'one'].

	[parser peek isStartTag]
		whileTrue: [elements addLast: parser nextNode].

	self
		assert: (elements allSatisfy: [:each | each isElement]);
		assert: (elements collect: [:each | each name]) asArray = #('two' 'four' 'five' 'six');
		assert: (parser next isEndTagNamed: 'one').
]

{ #category : #tests }
StAXParserTest >> testNextUntil [
	| parser events |

	parser := StAXParser on: self sampleXML.
	events := parser nextUntil: [parser peek isStartTagNamed: 'two'].
	self
		assert: events size = 2;
		assert: events first isStartDocument;
		assert: (events second isStartTagNamed: 'one');
		assert: (parser next isStartTagNamed: 'two').

	parser := StAXParser on: self sampleXML.
	events := parser nextUntil: [parser current isStartTagNamed: 'six'].
	self
		assert: events size = 16;
		assert: (events last isStartTagNamed: 'six');
		assert: (parser next isEndTagNamed: 'six').

	self assertIsSampleXMLEvents:
		((StAXParser on: self sampleXML) nextUntil: [false]).
	self assert:
		((StAXParser on: self sampleXML) nextUntil: [true]) isEmpty.
]

{ #category : #tests }
StAXParserTest >> testNextWhile [
	| parser events |

	parser := StAXParser on: self sampleXML.
	events := parser nextWhile: [(parser peek isStartTagNamed: 'two') not].
	self
		assert: events size = 2;
		assert: events first isStartDocument;
		assert: (events second isStartTagNamed: 'one');
		assert: (parser next isStartTagNamed: 'two').

	parser := StAXParser on: self sampleXML.
	events := parser nextWhile: [(parser current isStartTagNamed: 'six') not].
	self
		assert: events size = 16;
		assert: (events last isStartTagNamed: 'six');
		assert: (parser next isEndTagNamed: 'six').

	self assertIsSampleXMLEvents:
		((StAXParser on: self sampleXML) nextWhile: [true]).
	self assert:
		((StAXParser on: self sampleXML) nextWhile: [false]) isEmpty.
]

{ #category : #tests }
StAXParserTest >> testOn [
	| parser oldConfiguration oldDOMBuilder |

	(parser := StAXParser on: self sampleXML) nextNode.
	oldConfiguration := parser configuration.
	oldDOMBuilder := parser domBuilder.

	parser on: self sampleXML.
	self
		deny: parser configuration == oldConfiguration;
		deny: parser domBuilder == oldConfiguration;
		deny: parser atEnd;
		assert: parser current isInitialEvent;
		assert: parser eventQueue isEmpty;
		assert: parser lastEventAdded isNil.
]

{ #category : #tests }
StAXParserTest >> testParseDocument [
	self assertIsSampleXMLEvents: (StAXParser on: self sampleXML) parseDocument
]

{ #category : #tests }
StAXParserTest >> testParseDocumentUntil [
	| parser events |

	parser := StAXParser on: self sampleXML.
	events := parser parseDocumentUntil: [parser peek isStartTagNamed: 'two'].
	self
		assert: events size = 2;
		assert: events first isStartDocument;
		assert: (events second isStartTagNamed: 'one');
		assert: (parser next isStartTagNamed: 'two').

	parser := StAXParser on: self sampleXML.
	events := parser parseDocumentUntil: [parser current isStartTagNamed: 'six'].
	self
		assert: events size = 16;
		assert: (events last isStartTagNamed: 'six');
		assert: (parser next isEndTagNamed: 'six').

	self assertIsSampleXMLEvents:
		((StAXParser on: self sampleXML) parseDocumentUntil: [false]).
	self assert:
		((StAXParser on: self sampleXML) parseDocumentUntil: [true]) isEmpty.
]

{ #category : #tests }
StAXParserTest >> testParseDocumentWhile [
	| parser events |

	parser := StAXParser on: self sampleXML.
	events := parser parseDocumentWhile: [(parser peek isStartTagNamed: 'two') not].
	self
		assert: events size = 2;
		assert: events first isStartDocument;
		assert: (events second isStartTagNamed: 'one');
		assert: (parser next isStartTagNamed: 'two').

	parser := StAXParser on: self sampleXML.
	events := parser parseDocumentWhile: [(parser current isStartTagNamed: 'six') not].
	self
		assert: events size = 16;
		assert: (events last isStartTagNamed: 'six');
		assert: (parser next isEndTagNamed: 'six').

	self assertIsSampleXMLEvents:
		((StAXParser on: self sampleXML) parseDocumentWhile: [true]).
	self assert:
		((StAXParser on: self sampleXML) parseDocumentWhile: [false]) isEmpty.
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
StAXParserTest >> testSkipUntil [
	| parser |

	(parser := StAXParser on: self sampleXML)
		skipUntil: [parser peek isStartTagNamed: 'three'].
	self assert: (parser next isStartTagNamed: 'three').

	(parser := StAXParser on: self sampleXML)
		skipUntil: [false].
	self assert: parser atEnd.

	(parser := StAXParser on: self sampleXML)
		skipUntil: [parser current isStartTagNamed: 'six'].
	self assert: (parser next isEndTagNamed: 'six').

	(parser := StAXParser on: self sampleXML)
		skipUntil: [true].
	self assert: parser next isStartDocument.
]

{ #category : #tests }
StAXParserTest >> testSkipWhile [
	| parser |

	(parser := StAXParser on: self sampleXML)
		skipWhile: [(parser peek isStartTagNamed: 'three') not].
	self assert: (parser next isStartTagNamed: 'three').

	(parser := StAXParser on: self sampleXML)
		skipWhile: [true].
	self assert: parser atEnd.

	(parser := StAXParser on: self sampleXML)
		skipWhile: [(parser current isStartTagNamed: 'six') not].
	self assert: (parser next isEndTagNamed: 'six').

	(parser := StAXParser on: self sampleXML)
		skipWhile: [false].
	self assert: parser next isStartDocument.
]

{ #category : #tests }
StAXParserTest >> testSkipsCommentEvents [
	| xml parser |

	xml := '
		<test>
			<!--comment-->
		</test>'.
	(parser := StAXParser on: xml) next: 2.
	self deny: parser next isComment.

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
StAXParserTest >> testUsesSeparateCDataEvents [
	| xml parser |

	xml := '
		<test>
			<![CDATA[cdata text]]>
		</test>'.
	parser := StAXParser on: xml.
	parser next: 2.
	self
		assert: parser peek isText;
		deny: parser peek isCData;
		assert: (parser next isText: 'cdata text').

	(parser := StAXParser on: xml)
		usesSeparateCDataEvents: true;
		next: 2.
	self
		assert: parser peek isText;
		assert: parser peek isCData;
		assert: (parser next isText: 'cdata text').

	(parser := StAXParser on: xml)
		usesSeparateCDataEvents: false;
		next: 2.
	self
		assert: parser peek isText;
		deny: parser peek isCData;
		assert: (parser next isText: 'cdata text').
]

{ #category : #tests }
StAXParserTest >> testWriteEvents [
	| events document |

	events := StAXParser parse: self sampleXML.
	document := XMLDOMParser parse: self sampleXML.
	self assert:
		(XMLWriter writeWith: [:writer | writer writeEvents: events]) =
			document root printString.

	events := 
		(StAXParser on: self sampleXML)
			skipsCommentEvents: false;
			usesSeparateCDataEvents: true;
			upToEnd.
	document :=
		(XMLDOMParser on: self sampleXML)
			preservesCommentNodes: true;
			preservesCDataNodes: true;
			parseDocument.
	self assert:
		(XMLWriter writeWith: [:writer | writer writeEvents: events]) =
			document root printString.
]
