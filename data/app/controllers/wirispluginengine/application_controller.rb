require_dependency "wirispluginengine/integration/configurationjs"
require_dependency "wirispluginengine/integration/createimage"
require_dependency "wirispluginengine/integration/showimage"
require_dependency "wirispluginengine/integration/service"
require_dependency "wirispluginengine/integration/getmathml"
require_dependency "wirispluginengine/integration/test"

module Wirispluginengine
  class ApplicationController < ActionController::Base
    def integration
      #Loading resources for WirisPlugin (gem/resources dir).
      spec = Gem::Specification.find_by_name("wirispluginengine")
      gem_root = spec.gem_dir
      Storage.resourcesDir = gem_root.to_s + '/resources'

      wirishash = Wiris::Hash.new()
      params.each do |key, value|
        wirishash[key] = value
      end
      propertiesparams = PropertiesTools.toProperties(wirishash)
      case self.params[:script].inspect.gsub('"', '')
      when 'configurationjs'
        configurationjs = Configurationjs.new
        render :js =>  configurationjs.dispatch(request, response)
      when 'createimage'
        createimage = CreateImage.new
        render :text => createimage.dispatch(request, response, propertiesparams)
      when 'showimage'
        showimage = ShowImage.new
        image = showimage.dispatch(request, response, propertiesparams)
        send_data image.pack("C*"), :type => response.content_type, :disposition => 'inline'
      when 'service'
        service = Service.new()
        render :text => service.dispatch(request, response, propertiesparams)
      when 'getmathml'
        getmathml = GetMathMLDispatcher.new()
        render :text => getmathml.dispatch(request, response, propertiesparams)
      when 'test'
        #test variable changed to wiristest
        #in order to avoid conflict with rails production console
        wiristest = WirisTest.new()
        render :text => wiristest.dispatch(request)
      else
        render plain:"Method no exists"
      end
      Storage.resourcesDir = nil
    end
  end
end