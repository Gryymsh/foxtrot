require 'ffi'

module LibC
  extend FFI::Library
  
  # Determine correct LibC
  library = ffi_lib(FFI::Library::LIBC)
  
  attach_function :malloc, [:size_t], :pointer
  attach_function :free, [:pointer], :void
  
  #Free = library.find_symbol('free')
  
  attach_function :memcpy, [:pointer, :pointer, :size_t], :pointer
end

module LibSmbClient
  extend FFI::Library
  
  LINUX = ["libsmbclient", "/usr/local/lib/libsmbclient", "/usr/local/lib/libsmbclient.so", "/opt/local/lib/smbclient"]
  OSX = ["libsmbclient", "/usr/lib/samba/libsmbclient", "/usr/lib/samba/libsmbclient.dylib", "/opt/local/lib/samba/smbclient" ]
  SOLARIS = []
  
  ffi_lib(LINUX + OSX + SOLARIS)
  

  
  attach_function :smbc_getFunctionAuthData, [:struct], :pointer
  callback :smbc_get_auth_data_fn, [:string, :string, :string, :int, :string, :int, :string, :int], :void
  callback :smbc_get_auth_data_with_context_fn, [:pointer, :string, :string, :int, :string, :int, :string, :int], :void
  attach_function :smbc_init, [:smbc_get_auth_data_fn, :int], :int
  
  attach_function :smbc_open, [:string, :int, :mode_t], :int
  attach_function :smbc_creat, [:string, :mode_t], :int
    
  module ClassMethods
    def open(url)
      return true
    end
  end
  
  module InstanceMethods
    
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end

module Foxtrot
  include LibSmbClient
end