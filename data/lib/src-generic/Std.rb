class Std
	def self.trace(s)
		puts s
	end

	def self.is(o, cls)
		 raise Exception,'Error: '+ __callee__.to_s  + ' method not defined'
	end

	def self.substr(text, x0, length=-1)
		if length==-1
			text[x0..text.length]
		else
			text[x0,length] # Strings starts at 0
		end
	end

	def split(text, delimitator)
		raise Exception,'Error: '+ __callee__.to_s  + ' method not defined'
	end

	def self.parseInt(number)
		return Integer(number)
	end

	def self.parseFloat(number)
		return Float(number)
	end

	# @deprecated
    def parseDouble(number)
		raise Exception,'Error: '+ __callee__.to_s  + ' method not defined'
    end

    def self.fromCharCode(c)
		return c.chr(Encoding::UTF_8)
    end

    def self.charCodeAt(str, i)
		return str[i].ord
    end

    def copyInto(array, cs)
		raise Exception,'Error: '+ __callee__.to_s  + ' method not defined'
    end

    def exit(n)
		raise Exception,'Error: '+ __callee__.to_s  + ' method not defined'
    end

    def random(x)
		raise Exception,'Error: '+ __callee__.to_s  + ' method not defined'
    end

    def self.split(str, delimitator)
    	arr = Wiris::Array.new()
		if (index = str.index(delimitator))
			length = str.scan(delimitator).length
			for i in 0..length
				if (index)
					arr._(i,str[0,index])
					str=str[index+1, str.length]
					index = str.index(delimitator)
				else
					arr._(i,str)
				end
			end
		end
		return arr
    end

    @@random  = nil 
    def self.random=(random)
    	@@random=random
    end
    def self.random(x) 
      if @@random == nil
      	@@random = Random.new()
      end
      return @@random.rand(x)
    end

end
