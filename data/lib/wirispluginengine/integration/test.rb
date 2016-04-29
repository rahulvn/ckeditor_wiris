class WirisTest
	def dispatch(request)
		pb = PluginBuilderImpl.new()
		rcu = RubyConfigurationUpdater.new()
		rcu.request= request
		pb.addConfigurationUpdater(rcu)
		r = pb.newTest().getTestPage()
		return r
	end
end