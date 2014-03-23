module MetaProject
  class DSL
    def initialize
      @attributes = []
    end

    def project name, &block
      @mod = Object.const_set name.to_s.capitalize, Module.new
      self.instance_eval &block if block_given?
      puts "Created module #@mod."
    end

    def klass name, &block
      klass = @mod.const_set name.to_s.capitalize, Class.new
      self.instance_eval &block if block_given?
      klass.class_eval <<EOF
#{accessible_attributes}
#{initializer}
EOF
      @attributes.clear

      puts "Created class #{klass}."
    end

    def attribute name
      @attributes << name
    end

    def accessible_attributes
      "attr_accessor #{attributes_as_symbols}"
    end

    def attributes_as_symbols
      @attributes.map {|attr| ":#{attr}"}.join ", "
    end

    def initializer
      <<EOF
def initialize #{attributes_as_arguments}
  #{initialized_arguments}
end
EOF
    end

    def attributes_as_arguments
      @attributes.join ", "
    end

    def initialized_arguments
      @attributes.map do |attribute|
        "@#{attribute} = #{attribute}"
      end.join "\n"
    end
  end
end