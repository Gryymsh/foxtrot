require 'ffi'
require 'bundler/setup'

require File.expand_path('../foxtrot/dir', __FILE__)
require File.expand_path('../foxtrot/file', __FILE__)

module Foxtrot
  
  LIBPATH = ::File.expand_path(::File.dirname(__FILE__)) + ::FILE::SEPARATOR
  PATH = ::File.dirname(LIBPATH) + ::File::SEPARATOR
  
  # Returns library path. Args joined to end of path.
  def self.libpath(*args, &block)
    val = args.empty? ? LIBPATH : ::File.join(LIBPATH, args.flatten)
    if block
      begin
        $LOAD_PATH.unshift LIBPATH
        val = block.call
      ensure
        $LOAD_PATH.shift
      end
    end
    return val
  end
  
  def self.path(*args, &block)
    val = args.empty? ? PATH : ::File.join(PATH, args.flatten)
    if block
      begin
        $LOAD_PATH.unshift LIBPATH
        val = block.call
      ensure
        $LOAD_PATH.shift
      end
    end
    return val
  end
  
  # Utility method used to require all files ending in .rb that lie in the
  # directory below this file that has the same name as the filename passed
  # in. Optionally, a specific _directory_ name can be passed in such that
  # the _filename_ does not have to be equivalent to the directory.
  #
  def self.require_all_libs_relative_to( fname, dir = nil )
    dir ||= ::File.basename(fname, '.*')
    search_me = ::File.expand_path(
    ::File.join(::File.dirname(fname), dir, '**', '*.rb'))

    Dir.glob(search_me).sort.each {|rb| require rb}
  end
  
end

%w(client file dir print).each do |file|
  require Foxtrot.libpath(['foxtrot', 'file')
end
  

