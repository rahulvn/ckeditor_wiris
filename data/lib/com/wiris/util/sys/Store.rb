
class Store
  def file
    @file
  end
  def file=(file)
    @file=file
  end
  def initialize()
    super()
  end
  def self.newStore(folder)
    s = Store.new()
    s::file = folder
    return s
  end
  def list()
    return FileSystem::readDirectory(@file)
  end
  def mkdirs()
    parent = getParent()
    if !parent::exists()
      parent::mkdirs()
    end
    if !exists()
      FileSystem::createDirectory(@file)
    end
  end
  def write(str)
    File::saveContent(@file,str)
  end
  def writeBinary(bs)
    File::saveBytes(@file,bs)
  end
  def readBinary()
    return File::getBytes(@file)
  end
  def append(str)
    output = File::append(@file,true)
    output::writeString(str)
    output::flush()
    output::close()
  end
  def read()
    return File::getContent(@file)
  end
  def self.newStoreWithParent(store,str)
    return newStore((store::getFile()+"/")+str)
  end
  def getFile()
    return @file
  end
  def exists()
    return FileSystem::exists(@file)
  end
  def self.getCurrentPath()
    return FileSystem::fullPath(".")
  end
  def getParent()
    parent = FileSystem::fullPath(@file)
    if parent==nil
      parent = @file
    end
    i = WInteger::max(parent::lastIndexOf("/"),parent::lastIndexOf("\\"))
    if i<0
      return self.class.newStore(".")
    end
    parent = Std::substr(parent,0,i)
    return self.class.newStore(parent)
  end
  def copyTo(dest)
    b = readBinary()
    dest::writeBinary(b)
  end
  def moveTo(dest)
    FileSystem::rename(@file,dest::getFile())
  end
end