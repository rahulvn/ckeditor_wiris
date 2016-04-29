
class FileConfigurationUpdater
extend ConfigurationUpdaterInterface

  def initialize()
    super()
  end
  def init(obj)
  end
  def updateConfiguration(ref_configuration)
    configuration = ref_configuration
    confDir = PropertiesTools::getProperty(configuration,ConfigurationKeys::CONFIGURATION_PATH)
    if confDir!=nil
      confFile = confDir+"/configuration.ini"
      s = Storage::newStorage(confFile)
      if s::exists()
        defaultIniFile = IniFile::newIniFileFromFilename(confFile)
        h = defaultIniFile::getProperties()
        iter = h::keys()
        while iter::hasNext()
          key = iter::next()
          PropertiesTools::setProperty(configuration,key,h::get(key))
        end
      end
    end
  end
end