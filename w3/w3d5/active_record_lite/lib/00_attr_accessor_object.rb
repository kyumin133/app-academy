class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      define_method(name.to_sym) do
        self.instance_variable_get("@#{name}")
      end
      define_method("#{name}=".to_sym) do |val|
        self.instance_variable_set("@#{name}", val)
      end
    end
  end
end
