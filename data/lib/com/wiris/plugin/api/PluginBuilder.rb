
class PluginBuilder
  def initialize()
    super()
  end
  def self.getInstance()
    return PluginBuilderImpl.new()
  end
  def addConfigurationUpdater(conf)
  end
  def setStorageAndCache(store)
  end
  def newRender()
    return nil
  end
  def newAsyncRender()
    return nil
  end
  def newTextService()
    return nil
  end
  def newAsyncTextService()
    return nil
  end
  def getConfiguration()
    return nil
  end
  def getStorageAndCache()
    return nil
  end
  def setStorageAndCacheInitObject(obj)
  end
  def newTest()
    return nil
  end
  def newCas()
    return nil
  end
  def newEditor()
    return nil
  end
  def addCorsHeaders(response,origin)
  end
end