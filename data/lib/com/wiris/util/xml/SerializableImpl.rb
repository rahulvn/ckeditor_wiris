
class SerializableImpl
  def initialize()
    super()
  end
  def onSerialize(s)
  end
  def newInstance()
    return SerializableImpl.new()
  end
  def serialize()
    s = XmlSerializer.new()
    return s::write(self)
  end
end