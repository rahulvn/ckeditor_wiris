class FileSystem
	def self.readDirectory(folder)
		return Dir::entries(folder)
	end

	def self.createDirectory(folder)
		Dir.mkdir(folder)
	end

	def self.exists(folder)
		File.exists?(folder)
	end

	def self.fullPath(path)
		if !exists(path)
			return nil
		end
		return File::realpath(path)
	end
	def self.rename (path, newpath)
		File::rename(path, newpath)
		raise Exception, "Unable to rename \""+path+"\" to \""+newpath+"\"."
	end
end