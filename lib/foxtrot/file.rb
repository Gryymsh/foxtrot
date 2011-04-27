module Foxtrot
  

  
  # Class to represent smbc file objects
  class File
    extend LibSmbClient


    
    def initialize(args)
      
    end
    
    def self.open(url, flags=0, mode=0)
      smbc_open(url, flags, mode )
    end
    
    
  end
  
end