class ShowImage
	def dispatch(request, response, params)
		pb = PluginBuilderImpl.new()
		rcu = RubyConfigurationUpdater.new()
		rcu.request = request
		pb.addConfigurationUpdater(rcu)
		render = pb.newRender()
		r = render.showImage(params.get('formula'), params.get('mml'), params)
		if pb.getConfiguration().getProperty("wirisimageformat", "png") == 'svg'
			response.content_type = 'image/svg+xml'
		else
			response.content_type = 'image/png'
		end		
		return r
	end
end
