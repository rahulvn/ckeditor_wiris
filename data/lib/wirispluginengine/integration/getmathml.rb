class GetMathMLDispatcher
    def dispatch(request, response, params)
        digest = nil
        latex = params.get("latex")
        md5Parameter = params.get("md5")

        if (md5Parameter != nil && md5Parameter.length() == 32)  # Support for "generic simple" integration.
            digest = md5Parameter
        else
            String digestParameter = request.getParameter("digest")
            if (digestParameter != nil) # Support for future integrations (where maybe they aren't using md5 sums).
                digest = digestParameter
            end
        end

        pb = PluginBuilderImpl.new()
        rcu = RubyConfigurationUpdater.new()
        rcu.request = request
        pb.addConfigurationUpdater(rcu)
        render = pb.newRender()
        r = pb.newTextService().getMathML(digest, latex)
        return r
    end
end
