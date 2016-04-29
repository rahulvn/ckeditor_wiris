class Service
    def dispatch(request, response, params)
        pb = PluginBuilderImpl.new()
        rcu = RubyConfigurationUpdater.new()
        rcu.request = request
        pb.addConfigurationUpdater(rcu)
        render = pb.newRender()
        r = pb.newTextService().service(params.get('service'),params);
        return r
    end
end