
class TextFilterTags
  def in_mathopen
    @in_mathopen
  end
  def in_mathopen=(in_mathopen)
    @in_mathopen=in_mathopen
  end
  def in_mathclose
    @in_mathclose
  end
  def in_mathclose=(in_mathclose)
    @in_mathclose=in_mathclose
  end
  def in_double_quote
    @in_double_quote
  end
  def in_double_quote=(in_double_quote)
    @in_double_quote=in_double_quote
  end
  def out_double_quote
    @out_double_quote
  end
  def out_double_quote=(out_double_quote)
    @out_double_quote=out_double_quote
  end
  def in_open
    @in_open
  end
  def in_open=(in_open)
    @in_open=in_open
  end
  def out_open
    @out_open
  end
  def out_open=(out_open)
    @out_open=out_open
  end
  def in_close
    @in_close
  end
  def in_close=(in_close)
    @in_close=in_close
  end
  def out_close
    @out_close
  end
  def out_close=(out_close)
    @out_close=out_close
  end
  def in_entity
    @in_entity
  end
  def in_entity=(in_entity)
    @in_entity=in_entity
  end
  def out_entity
    @out_entity
  end
  def out_entity=(out_entity)
    @out_entity=out_entity
  end
  def in_quote
    @in_quote
  end
  def in_quote=(in_quote)
    @in_quote=in_quote
  end
  def out_quote
    @out_quote
  end
  def out_quote=(out_quote)
    @out_quote=out_quote
  end
  def in_appletopen
    @in_appletopen
  end
  def in_appletopen=(in_appletopen)
    @in_appletopen=in_appletopen
  end
  def in_appletclose
    @in_appletclose
  end
  def in_appletclose=(in_appletclose)
    @in_appletclose=in_appletclose
  end
  def initialize()
    super()
  end
  def self.newSafeXml()
    tags = TextFilterTags.new()
    tags::in_open = Std::fromCharCode(171)
    tags::in_close = Std::fromCharCode(187)
    tags::in_entity = Std::fromCharCode(167)
    tags::in_quote = "`"
    tags::in_double_quote = Std::fromCharCode(168)
    tags::init(tags)
    return tags
  end
  def self.newXml()
    tags = TextFilterTags.new()
    tags::in_open = "<"
    tags::in_close = ">"
    tags::in_entity = "&"
    tags::in_quote = "\'"
    tags::in_double_quote = "\""
    tags::init(tags)
    return tags
  end
  def init(tags)
    tags::in_appletopen = @in_open+"APPLET"
    tags::in_appletclose = (@in_open+"/APPLET")+@in_close
    tags::in_mathopen = @in_open+"math"
    tags::in_mathclose = (@in_open+"/math")+@in_close
    tags::out_open = "<"
    tags::out_close = ">"
    tags::out_entity = "&"
    tags::out_quote = "\'"
    tags::out_double_quote = "\""
  end
end