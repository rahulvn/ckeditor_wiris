
class PluginBuilderImpl < PluginBuilder
  def configuration
    @configuration
  end
  def configuration=(configuration)
    @configuration=configuration
  end
  def store
    @store
  end
  def store=(store)
    @store=store
  end
  def updaterChain
    @updaterChain
  end
  def updaterChain=(updaterChain)
    @updaterChain=updaterChain
  end
  def storageAndCacheInitObject
    @storageAndCacheInitObject
  end
  def storageAndCacheInitObject=(storageAndCacheInitObject)
    @storageAndCacheInitObject=storageAndCacheInitObject
  end
  def initialize()
    super()
    @updaterChain = Wiris::Array.new()
    @updaterChain::push(DefaultConfigurationUpdater.new())
    ci = ConfigurationImpl.new()
    @configuration = ci
    ci::setPluginBuilderImpl(self)
  end
  def addConfigurationUpdater(conf)
    @updaterChain::push(conf)
  end
  def setStorageAndCache(store)
    @store = store
  end
  def newRender()
    return RenderImpl.new(self)
  end
  def newAsyncRender()
    return AsyncRenderImpl.new(self)
  end
  def newTest()
    return TestImpl.new(self)
  end
  def newEditor()
    return EditorImpl.new(self)
  end
  def newCas()
    return CasImpl.new(self)
  end
  def newTextService()
    return TextServiceImpl.new(self)
  end
  def newAsyncTextService()
    return AsyncTextServiceImpl.new(self)
  end
  def getConfiguration()
    return @configuration
  end
  def getStorageAndCache()
    if @store==nil
      className = @configuration::getProperty(ConfigurationKeys::STORAGE_CLASS,nil)
      if (className==nil)||(className=="FolderTreeStorageAndCache")
        @store = FolderTreeStorageAndCache.new()
      else 
        if (className=="FileStorageAndCache")
          @store = FileStorageAndCache.new()
        else 
          cls = Type::resolveClass(className)
          if cls==nil
            raise Exception,("Class "+className)+" not found."
          end
          @store = (Type::createInstance(cls,Wiris::Array.new()))
          if @store==nil
            raise Exception,("Instance from "+cls.to_s)+" cannot be created."
          end
        end
      end
      initialize_(@store,@configuration::getFullConfiguration())
    end
    return @store
  end
  def initialize_(sac,conf)
    sac::init(@storageAndCacheInitObject,conf)
  end
  def getConfigurationUpdaterChain()
    return @updaterChain
  end
  def setStorageAndCacheInitObject(obj)
    @storageAndCacheInitObject = obj
  end
  def getImageServiceURL(service,stats)
    config = getConfiguration()
    protocol = config::getProperty(ConfigurationKeys::SERVICE_PROTOCOL,nil)
    port = config::getProperty(ConfigurationKeys::SERVICE_PORT,nil)
    url = config::getProperty(ConfigurationKeys::INTEGRATION_PATH,nil)
    if (protocol==nil)&&(url!=nil)
      if StringTools::startsWith(url,"https")
        protocol = "https"
      end
    end
    if protocol==nil
      protocol = "http"
    end
    if port!=nil
      if (protocol=="http")
        if !(port=="80")
          port = ":"+port
        else 
          port = ""
        end
      end
      if (protocol=="https")
        if !(port=="443")
          port = ":"+port
        else 
          port = ""
        end
      end
    else 
      port = ""
    end
    domain = config::getProperty(ConfigurationKeys::SERVICE_HOST,nil)
    path = config::getProperty(ConfigurationKeys::SERVICE_PATH,nil)
    if service!=nil
      _end = path::lastIndexOf("/")
      if _end==-1
        path = service
      else 
        path = (Std::substr(path,0,_end).to_s+"/")+service
      end
    end
    if stats
      path = addStats(path)
    end
    return (((protocol+"://")+domain)+port)+path
  end
  def addProxy(h)
    conf = getConfiguration()
    proxyEnabled = conf::getProperty(ConfigurationKeys::HTTPPROXY,"false")
    if (proxyEnabled=="true")
      host = conf::getProperty(ConfigurationKeys::HTTPPROXY_HOST,nil)
      port = Std::parseInt(conf::getProperty(ConfigurationKeys::HTTPPROXY_PORT,"80"))
      if (host!=nil)&&(host::length()>0)
        user = conf::getProperty(ConfigurationKeys::HTTPPROXY_USER,nil)
        pass = conf::getProperty(ConfigurationKeys::HTTPPROXY_PASS,nil)
        h::setProxy(HttpProxy::newHttpProxy(host,port,user,pass))
      end
    end
  end
  def addReferer(h)
    conf = getConfiguration()
    if (conf::getProperty("wirisexternalplugin","false")=="true")
      h::setHeader("Referer",conf::getProperty(ConfigurationKeys::EXTERNAL_REFERER,"external referer not found"))
    else 
      h::setHeader("Referer",conf::getProperty(ConfigurationKeys::REFERER,""))
    end
  end
  def addCorsHeaders(response,origin)
    conf = getConfiguration()
    if (conf::getProperty("wiriscorsenabled","false")=="true")
      confDir = conf::getProperty(ConfigurationKeys::CONFIGURATION_PATH,nil)
      corsConfFile = confDir+"/corsservers.ini"
      s = Storage::newStorage(corsConfFile)
      if s::exists()
        dir = s::read()
        allowedHosts = Std::split(dir,"\n")
        if allowedHosts::contains_(origin)
          response::setHeader("Access-Control-Allow-Origin",origin)
        end
      else 
        response::setHeader("Access-Control-Allow-Origin","*")
      end
    end
  end
  def addStats(url)
    saveMode = getConfiguration()::getProperty(ConfigurationKeys::SAVE_MODE,"xml")
    externalPlugin = getConfiguration()::getProperty(ConfigurationKeys::EXTERNAL_PLUGIN,"false")
    begin
    version = Storage::newResourceStorage("VERSION")::read()
    end
    begin
    tech = Storage::newResourceStorage("tech.txt")::read()
    end
    if url::indexOf("?")!=-1
      return (((((((url+"&stats-mode=")+saveMode)+"&stats-version=")+version)+"&stats-scriptlang=")+tech)+"&external=")+externalPlugin
    else 
      return (((((((url+"?stats-mode=")+saveMode)+"&stats-version=")+version)+"&stats-scriptlang=")+tech)+"&external=")+externalPlugin
    end
  end
end