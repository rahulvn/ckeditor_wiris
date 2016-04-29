
class HttpConnection < Http
  def listener
    @listener
  end
  def listener=(listener)
    @listener=listener
  end
  def initialize(url,listener)
    super(url)
    @listener = listener
  end
  def onData(data)
    listener::onHTTPData(data)
  end
  def onError(error)
    listener::onHTTPError(error)
  end
end