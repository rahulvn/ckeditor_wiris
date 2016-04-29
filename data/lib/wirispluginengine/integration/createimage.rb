class CreateImage
	def dispatch(request, response, params)
		mml = params.get('mml')
		pb = PluginBuilderImpl.new()
		rcu = RubyConfigurationUpdater.new()
		rcu.request = request
		pb.addConfigurationUpdater(rcu)
		render = pb.newRender()
		digest = render.computeDigest(mml, params)
		render.computeDigest(mml, params)
		a = render.createImage(mml, params, nil)
		return a
	end
end