
class XmlWriter
  INDENT_STRING = "   "
  ECHO_FILTER = 2
  AUTO_IGNORING_SPACE_FILTER = 1
  PRETTY_PRINT_FILTER = 0
  @prettyPrint = true
  def prettyPrint
    @prettyPrint
  end
  def prettyPrint=(prettyPrint)
    @prettyPrint=prettyPrint
  end
  @xmlDeclaration = false
  def xmlDeclaration
    @xmlDeclaration
  end
  def xmlDeclaration=(xmlDeclaration)
    @xmlDeclaration=xmlDeclaration
  end
  @autoIgnoringWhitespace = true
  def autoIgnoringWhitespace
    @autoIgnoringWhitespace
  end
  def autoIgnoringWhitespace=(autoIgnoringWhitespace)
    @autoIgnoringWhitespace=autoIgnoringWhitespace
  end
  def inlineElements
    @inlineElements
  end
  def inlineElements=(inlineElements)
    @inlineElements=inlineElements
  end
  def filter
    @filter
  end
  def filter=(filter)
    @filter=filter
  end
  def tagOpen
    @tagOpen
  end
  def tagOpen=(tagOpen)
    @tagOpen=tagOpen
  end
  def firstLine
    @firstLine
  end
  def firstLine=(firstLine)
    @firstLine=firstLine
  end
  def inline
    @inline
  end
  def inline=(inline)
    @inline=inline
  end
  def inlineMark
    @inlineMark
  end
  def inlineMark=(inlineMark)
    @inlineMark=inlineMark
  end
  def depth
    @depth
  end
  def depth=(depth)
    @depth=depth
  end
  def cdataSection
    @cdataSection
  end
  def cdataSection=(cdataSection)
    @cdataSection=cdataSection
  end
  def currentPrefixes
    @currentPrefixes
  end
  def currentPrefixes=(currentPrefixes)
    @currentPrefixes=currentPrefixes
  end
  def hasWhiteSpace
    @hasWhiteSpace
  end
  def hasWhiteSpace=(hasWhiteSpace)
    @hasWhiteSpace=hasWhiteSpace
  end
  def nameSpace
    @nameSpace
  end
  def nameSpace=(nameSpace)
    @nameSpace=nameSpace
  end
  def whiteSpace
    @whiteSpace
  end
  def whiteSpace=(whiteSpace)
    @whiteSpace=whiteSpace
  end
  def sb
    @sb
  end
  def sb=(sb)
    @sb=sb
  end
  def initialize()
    super()
    @filter = PRETTY_PRINT_FILTER
    @xmlDeclaration = false
    @inlineElements = Wiris::Array.new()
    @firstLine = generateFirstLine("UTF-8")
    reset()
  end
  def setFilter(filterType)
    @filter = filterType
  end
  def getFilter()
    return @filter
  end
  def setXmlDeclaration(xmlFragment)
    @xmlDeclaration = xmlFragment
  end
  def isXmlDeclaration()
    return @xmlDeclaration
  end
  def setInlineElements(inlineElements)
    if inlineElements!=nil
      @inlineElements = inlineElements
    else 
      @inlineElements = Wiris::Array.new()
    end
  end
  def getInlineElements()
    return @inlineElements
  end
  def startDocument()
    reset()
    if @xmlDeclaration
      write(@firstLine)
    end
    if !@prettyPrint
      write("\n")
    end
  end
  def endDocument()
    closeOpenTag(false)
  end
  def startPrefixMapping(prefix,uri)
    if (uri==@currentPrefixes::get(prefix))
      return 
    end
    if uri::length()==0
      return 
    end
    pref = prefix
    if prefix::length()>0
      pref = ":"+prefix
    end
    ns = (((" xmlns"+pref)+"=\"")+uri)+"\""
    @nameSpace::add(ns)
    @currentPrefixes::set(prefix,uri)
  end
  def endPrefixMapping(prefix)
    @currentPrefixes::remove(prefix)
  end
  def startElement(uri,localName,qName,atts)
    closeOpenTag(false)
    processWhiteSpace(@inline||!(@autoIgnoringWhitespace||@prettyPrint))
    if @prettyPrint&&!@inline
      writeIndent()
    end
    name = qName
    if (name==nil)||(name::length()==0)
      name = localName
    end
    write("<"+name)
    writeAttributes(atts)
    if @nameSpace!=nil
      write(@nameSpace::toString())
      @nameSpace = nil
    end
    @tagOpen = true
    if !@inline&&@inlineElements::contains_(name)
      @inlineMark = @depth
      @inline = true
    end
    @depth+=1
  end
  def endElement(uri,localName,qName)
    name = qName
    if (name==nil)||(name::length()==0)
      name = localName
    end
    writeSpace = (@tagOpen||@inline)||!(@autoIgnoringWhitespace||@prettyPrint)
    processWhiteSpace(writeSpace)
    @depth-=1
    if @tagOpen
      closeOpenTag(true)
    else 
      if (!@inline&&@prettyPrint)&&!writeSpace
        writeIndent()
      end
      write(("</"+name)+">")
    end
    if @inline&&(@inlineMark==@depth)
      @inline = false
      @inlineMark = -1
    end
  end
  def startCDATA()
    closeOpenTag(false)
    write("<![CDATA[")
    @cdataSection = true
  end
  def endCDATA()
    @cdataSection = false
    write("]]>")
  end
  def characters(ch,start,length)
    if @cdataSection
      writeChars(ch,start,length)
    else 
      if !@inline
        if self.class.isWhiteSpace(ch,start,length)
          @hasWhiteSpace = true
            for i in start..start+length-1
              @whiteSpace::addChar(ch[i])
              i+=1
            end
          return 
        else 
          processWhiteSpace(true)
          @inlineMark = @depth-1
          @inline = true
        end
      end
      closeOpenTag(false)
      writeTextChars(ch,start,length)
    end
  end
  def writeChars(ch,start,length)
      for i in start..start+length-1
        @sb::addChar(ch[i])
        i+=1
      end
  end
  def write(s)
    @sb::add(s)
  end
  def writeText(s)
    @sb::add(WXmlUtils::htmlEscape(s))
  end
  def writeTextChars(ch,start,length)
    s = StringBuf.new()
      for i in start..start+length-1
        s::addChar(ch[i])
        i+=1
      end
    @sb::add(WXmlUtils::htmlEscape(s::toString()))
  end
  def self.isWhiteSpace(chars,start,length)
      for i in start..start+length-1
        c = chars[i]
        if !((((c==' ')||(c=="\n"))||(c=="\r"))||(c=="\t"))
          return false
        end
        i+=1
      end
    return true
  end
  def closeOpenTag(endElement)
    if @tagOpen
      if endElement
        write("/")
      end
      write(">")
      @tagOpen = false
    end
  end
  def writeAttributes(atts)
    if atts==nil
      return 
    end
      for i in 0..atts::getLength()-1
        name = atts::getName(i)
        value = atts::getValue(i)
        if name::startsWith("xmlns")
          prefix = nil
          uri = value
          if name::length()>5
            if name::charAt(6)==':'
              prefix = name::substring(6)
            end
          else 
            prefix = ""
          end
          if (prefix!=nil)&&(uri==@currentPrefixes::get(prefix))
              next
          end
        end
        write(" ")
        write(name)
        write("=\"")
        writeText(value)
        write("\"")
        i+=1
      end
  end
  def processWhiteSpace(write)
    if @hasWhiteSpace&&write
      closeOpenTag(false)
      writeText(@whiteSpace::toString())
    end
    @whiteSpace = StringBuf.new()
    @hasWhiteSpace = false
  end
  def writeIndent()
    write("\n")
      for i in 0..@depth-1
        write(INDENT_STRING)
        i+=1
      end
  end
  def generateFirstLine(encoding)
    return ("<?xml version=\"1.0\" encoding=\""+encoding)+"\"?>"
  end
  def reset()
    @tagOpen = false
    @inline = false
    @inlineMark = -1
    @depth = 0
    @cdataSection = false
    @hasWhiteSpace = false
    @currentPrefixes = Wiris::Hash.new()
    @whiteSpace = StringBuf.new()
    @nameSpace = StringBuf.new()
    @sb = StringBuf.new()
    if @filter==PRETTY_PRINT_FILTER
      @autoIgnoringWhitespace = true
      @prettyPrint = true
    else 
      if @filter==AUTO_IGNORING_SPACE_FILTER
        @autoIgnoringWhitespace = true
        @prettyPrint = false
      else 
        @autoIgnoringWhitespace = false
        @prettyPrint = false
      end
    end
  end
  def toString()
    return sb::toString()
  end
end