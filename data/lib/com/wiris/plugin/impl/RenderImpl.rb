
class RenderImpl
extend RenderInterface

  def plugin
    @plugin
  end
  def plugin=(plugin)
    @plugin=plugin
  end
  def initialize(plugin)
    super()
    @plugin = plugin
  end
  def computeDigest(mml,param)
    ss = getEditorParametersList()
    renderParams = Wiris::Hash.new()
      for i in 0..ss::length-1
        key = ss[i]
        value = PropertiesTools::getProperty(param,key)
        if value!=nil
          renderParams::set(key,value)
        end
        i+=1
      end
    if mml!=nil
      renderParams::set("mml",mml)
    end
    s = IniFile::propertiesToString(renderParams)
    return @plugin::getStorageAndCache()::codeDigest(s)
  end
  def createImage(mml,param,ref_output)
    output = ref_output
    if mml==nil
      raise Exception,"Missing parameter \'mml\'."
    end
    digest = computeDigest(mml,param)
    contextPath = @plugin::getConfiguration()::getProperty(ConfigurationKeys::CONTEXT_PATH,"/")
    showImagePath = @plugin::getConfiguration()::getProperty(ConfigurationKeys::SHOWIMAGE_PATH,nil)
    saveMode = @plugin::getConfiguration()::getProperty(ConfigurationKeys::SAVE_MODE,"xml")
    s = ""
    if (param!=nil)&&(PropertiesTools::getProperty(param,"metrics","false")=="true")
      s = getMetrics(digest,output)
    end
    a = ""
    if (param!=nil)&&(PropertiesTools::getProperty(param,"accessible","false")=="true")
      lang = PropertiesTools::getProperty(param,"lang","en")
      text = safeMath2Accessible(mml,lang,param)
      if output==nil
        a = "&text="+StringTools::urlEncode(text).to_s
      else 
        PropertiesTools::setProperty(output,"alt",text)
      end
    end
    rparam = ""
    if (param!=nil)&&(PropertiesTools::getProperty(param,"refererquery")!=nil)
      refererquery = PropertiesTools::getProperty(param,"refererquery")
      rparam = "&refererquery="+refererquery
    end
    if ((param!=nil)&&(PropertiesTools::getProperty(param,"base64")!=nil))||(saveMode=="base64")
      bs = showImage(digest,nil,param)
      by = Bytes::ofData(bs)
      b64 = Wiris::Base64.new()::encodeBytes(by)
      return "data:image/png;base64,"+b64::toString().to_s
    else 
      return (((self.class.concatPath(contextPath,showImagePath)+StringTools::urlEncode(digest).to_s)+s)+a)+rparam
    end
  end
  def showImage(digest,mml,param)
    if (digest==nil)&&(mml==nil)
      raise Exception,"Missing parameters \'formula\' or \'mml\'."
    end
    if (digest!=nil)&&(mml!=nil)
      raise Exception,"Only one parameter \'formula\' or \'mml\' is valid."
    end
    atts = false
    if (digest==nil)&&(mml!=nil)
      digest = computeDigest(mml,param)
    end
    formula = @plugin::getStorageAndCache()::decodeDigest(digest)
    if formula==nil
      raise Exception,"Formula associated to digest not found."
    end
    if formula::startsWith("<")
      raise Exception,"Not implemented."
    end
    iniFile = IniFile::newIniFileFromString(formula)
    renderParams = iniFile::getProperties()
    ss = getEditorParametersList()
    if param!=nil
        for i in 0..ss::length-1
          key = ss[i]
          value = PropertiesTools::getProperty(param,key)
          if value!=nil
            atts = true
            renderParams::set(key,value)
          end
          i+=1
        end
    end
    if atts
      if mml!=nil
        digest = computeDigest(mml,PropertiesTools::toProperties(renderParams))
      else 
        digest = computeDigest(renderParams::get("mml"),PropertiesTools::toProperties(renderParams))
      end
    end
    store = @plugin::getStorageAndCache()
    bs = nil
    bs = store::retreiveData(digest,@plugin::getConfiguration()::getProperty("wirisimageformat","png"))
    if bs==nil
      if @plugin::getConfiguration()::getProperty(ConfigurationKeys::EDITOR_PARAMS,nil)!=nil
        json = JSon::decode(@plugin::getConfiguration()::getProperty(ConfigurationKeys::EDITOR_PARAMS,nil))
        decodedHash = (json)
        keys = decodedHash::keys()
        notAllowedParams = Std::split(ConfigurationKeys::EDITOR_PARAMETERS_NOTRENDER_LIST,",")
        while keys::hasNext()
          key = keys::next()
          if !notAllowedParams::contains_(key)
            renderParams::set(key,(decodedHash::get(key)))
          end
        end
      else 
          for i in 0..ss::length-1
            key = ss[i]
            if !renderParams::exists(key)
              confKey = ConfigurationKeys::imageConfigProperties::get(key)
              if confKey!=nil
                value = @plugin::getConfiguration()::getProperty(confKey,nil)
                if value!=nil
                  renderParams::set(key,value)
                end
              end
            end
            i+=1
          end
      end
      renderParams::set("format",@plugin::getConfiguration()::getProperty("wirisimageformat","png"))
      h = HttpImpl.new(@plugin::getImageServiceURL(nil,true),nil)
      @plugin::addReferer(h)
      @plugin::addProxy(h)
      iter = renderParams::keys()
      while iter::hasNext()
        key = iter::next()
        h::setParameter(key,renderParams::get(key))
      end
      h::request(true)
      b = Bytes::ofString(h::getData())
      store::storeData(digest,@plugin::getConfiguration()::getProperty("wirisimageformat","png"),b::getData())
      bs = b::getData()
    end
    return bs
  end
  def getMathml(digest)
    return nil
  end
  def getEditorParametersList()
    pl = @plugin::getConfiguration()::getProperty(ConfigurationKeys::EDITOR_PARAMETERS_LIST,ConfigurationKeys::EDITOR_PARAMETERS_DEFAULT_LIST)
    return pl::split(",")
  end
  def getMetrics(digest,ref_output)
    output = ref_output
    begin
    bs = showImage(digest,nil,nil)
    end
    if @plugin::getConfiguration()::getProperty("wirisimageformat","png")::indexOf("svg")!=-1
      b = Bytes::ofData(bs)
      return getMetricsFromSvg(b::toString(),output)
    else 
      return getMetricsFromBytes(bs,output)
    end
  end
  def getMetricsFromSvg(svg,ref_output)
    output = ref_output
    svgXml = WXmlUtils::parseXML(svg)
    width = svgXml::firstElement()::get("width")
    height = svgXml::firstElement()::get("height")
    baseline = svgXml::firstElement()::get("wrs:baseline")
    if output!=nil
      PropertiesTools::setProperty(output,"width",""+width)
      PropertiesTools::setProperty(output,"height",""+height)
      PropertiesTools::setProperty(output,"baseline",""+baseline)
      r = ""
    else 
      r = (((("&cw="+width)+"&ch=")+height)+"&cb=")+baseline
    end
    return r
  end
  def getMetricsFromBytes(bs,ref_output)
    output = ref_output
    width = 0
    height = 0
    dpi = 0
    baseline = 0
    bys = Bytes::ofData(bs)
    bi = BytesInput.new(bys)
    n = bys::length()
    alloc = 10
    b = Bytes::alloc(alloc)
    bi::readBytes(b,0,8)
    n-= 8
    while n>0
      len = bi::readInt32()
      typ = bi::readInt32()
      if typ==1229472850
        width = bi::readInt32()
        height = bi::readInt32()
        bi::readInt32()
        bi::readByte()
      else 
        if typ==1650545477
          baseline = bi::readInt32()
        else 
          if typ==1883789683
            dpi = bi::readInt32()
            dpi = (Wiris::Math::round(dpi/39.37))
            bi::readInt32()
            bi::readByte()
          else 
            if len>alloc
              alloc = len
              b = Bytes::alloc(alloc)
            end
            bi::readBytes(b,0,len)
          end
        end
      end
      bi::readInt32()
      n-= len+12
    end
    if output!=nil
      PropertiesTools::setProperty(output,"width",""+width.to_s)
      PropertiesTools::setProperty(output,"height",""+height.to_s)
      PropertiesTools::setProperty(output,"baseline",""+baseline.to_s)
      if dpi!=96
        PropertiesTools::setProperty(output,"dpi",""+dpi.to_s)
      end
      r = ""
    else 
      r = (((("&cw="+width.to_s)+"&ch=")+height.to_s)+"&cb=")+baseline.to_s
      if dpi!=96
        r = (r+"&dpi=")+dpi.to_s
      end
    end
    return r
  end
  def safeMath2Accessible(mml,lang,param)
    begin
    text = @plugin::newTextService()::mathml2accessible(mml,lang,param)
    return text
    end
  end
  def self.concatPath(s1,s2)
    if s1::lastIndexOf("/")==(s1::length()-1)
      return s1+s2
    else 
      return (s1+"/")+s2
    end
  end
end