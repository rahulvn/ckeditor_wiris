module Wiris
	p "Loadin WirisPlugin..."
	if !defined?(Quizzesproxy)
		Dir[File.dirname(__FILE__) + '/src-generic/**/*.rb'].each {|file| require file}
		Dir[File.dirname(__FILE__) + '/src-generic/**/*/*.rb'].each {|file| require file}
	else 
		require 'src-generic/RubyConfigurationUpdater.rb'
	end

	Dir[File.dirname(__FILE__) + '/com/**/api/*.rb'].each {|file| require file}
	Dir[File.dirname(__FILE__) + '/com/**/storage/*.rb'].each {|file| require file}
	Dir[File.dirname(__FILE__) + '/com/**/configuration/*.rb'].each {|file| require file}
	Dir[File.dirname(__FILE__) + '/com/**/impl/*.rb'].each {|file| require file}
	Dir[File.dirname(__FILE__) + '/com/**/util/sys/*.rb'].each {|file| require file}
	Dir[File.dirname(__FILE__) + '/com/**/util/json/StringParser.rb'].each {|file| require file}
	Dir[File.dirname(__FILE__) + '/com/**/util/json/JSon.rb'].each {|file| require file}
	Dir[File.dirname(__FILE__) + '/com/**/util/xml/*.rb'].each {|file| require file}
	Dir[File.dirname(__FILE__) + '/com/**/common/*.rb'].each {|file| require file}
	p "WirisPlugin loaded."
end