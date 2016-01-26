module InlineSettings
  class Configuration
    def initialize(*args, &block)
      options = args.extract_options!
      klass = args.shift

      raise ArgumentError unless klass

      @klass = klass
      @klass.class_attribute :inline_settings_field_name, :inline_settings_fields, :inline_settings_prefix
      @klass.inline_settings_fields = {}
      @klass.inline_settings_field_name =  options[:field_name] ? options[:field_name].to_s : :inline_settings
      @klass.inline_settings_prefix =  options[:field_prefix] ? options[:field_prefix].to_s : ''


      if block_given?
        yield(self)
      end
    end

    def field(name, options={})
      raise ArgumentError.new("inline_settings: Symbol expected, but got a #{name.class}") unless name.is_a?(Symbol)
      @klass.inline_settings_fields[name] = options.freeze
    end

    def field_group(name, options = {})
      max = options[:max] ? options[:max] : 10
      (1..max).each do |i|
        @klass.inline_settings_fields[:"#{name}_#{i}"] = options.freeze
      end
    end


  end
end