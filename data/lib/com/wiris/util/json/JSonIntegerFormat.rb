
class JSonIntegerFormat
  HEXADECIMAL = 0
  def n
    @n
  end
  def n=(n)
    @n=n
  end
  def format
    @format
  end
  def format=(format)
    @format=format
  end
  def initialize(n,format)
    super()
    @n = n
    @format = format
  end
  def toString()
    if @format==HEXADECIMAL
      return "0x"+StringTools::hex(@n,0).to_s
    end
    return ""+@n.to_s
  end
end