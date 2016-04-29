
class StringParser
  def i
    @i
  end
  def i=(i)
    @i=i
  end
  def n
    @n
  end
  def n=(n)
    @n=n
  end
  def c
    @c
  end
  def c=(c)
    @c=c
  end
  def str
    @str
  end
  def str=(str)
    @str=str
  end
  def initialize()
    super()
  end
  def init(str)
    @str = str
    @i = 0
    @n = str::length()
    nextToken()
  end
  def skipBlanks()
    while (@i<@n)&&self.class.isBlank(@c)
      nextToken()
    end
  end
  def nextToken()
    if @c==-1
      raise Exception,"End of string"
    end
    nextSafeToken()
  end
  def nextSafeToken()
    if @i<@n
      @c = Utf8::charCodeAt(Std::substr(@str,@i),0)
      @i+=(Utf8::uchr(@c))::length()
    else 
      @c = -1
    end
  end
  def self.isBlank(c)
    return ((((c==32)||(c==10))||(c==13))||(c==9))||(c==160)
  end
  def getPositionRepresentation()
    i0 = WInteger::min(@i,@n)
    s0 = WInteger::max(0,@i-20)
    e0 = WInteger::min(@n,@i+20)
    return (("..."+Std::substr(@str,s0,i0-s0).to_s)+" >>> . <<<")+Std::substr(@str,i0,e0).to_s
  end
  def isHexDigit(c)
    if (c>=48)&&(c<=58)
      return true
    end
    if (c>=97)&&(c<=102)
      return true
    end
    if (c>=65)&&(c<=70)
      return true
    end
    return false
  end
end