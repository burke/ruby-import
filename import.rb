module RubyImport
  @@imports = {}

  def self.import(feature)
    path = resolve_feature(feature)
    return @@imports[path] if @@imports[path]

    code = File.read(path)
    mod = Module.new do
      def self.export(val)
        @__export__ = val
      end
      instance_eval(code)
    end

    val = mod.instance_variable_get(:@__export__)
    @@imports[path] = val
  end


  def self.resolve_feature(feature)
    return feature if feature.start_with?('./')

    $LOAD_PATH.each do |entry|
      candidate = File.join(entry, feature+".rb")
      return candidate if File.exist?(candidate)
    end
  end
end

def export(val)
  # nothing
end

class Module
  def import(feature)
    RubyImport.import(feature)
  end
end
