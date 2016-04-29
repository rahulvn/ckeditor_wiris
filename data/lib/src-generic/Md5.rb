require 'digest/md5'

class Md5
	def self.encode(content)
		return Digest::MD5.hexdigest(content)
	end

end
