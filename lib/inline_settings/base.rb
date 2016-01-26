module InlineSettings
  module Base
    def self.included(base)
      base.class_eval do
        serialize self.inline_settings_field_name, JSON        

        def self.inline_settings_accessor(name)
          prefix = inline_settings_prefix.blank? ? '' : "#{inline_settings_prefix}_"
          define_method(:"#{prefix}#{name}") { get_inline_setting(:"#{name}") }
          define_method(:"#{prefix}#{name}=") { |val| set_inline_setting(:"#{name}", val) }
        end        


      end

      base.inline_settings_fields.each do |name, settings|
        base.inline_settings_accessor(name)
      end

    end


    def get_inline_setting(key)
      raise ArgumentError unless key.is_a?(Symbol)
      raise ArgumentError.new("Unknown key: #{key}") unless self.class.inline_settings_fields[key]

      settings_field = send(self.class.inline_settings_field_name)
      settings_field = {} if settings_field.nil?


      unless settings_field.has_key? key.to_s
        default = self.class.inline_settings_fields[key].has_key?(:default) ? self.class.inline_settings_fields[key][:default] : ''
        settings_field[key.to_s] = default
        send("#{self.class.inline_settings_field_name}=", settings_field)
      end

      setting = settings_field[key.to_s]
      case self.class.inline_settings_fields[key][:type]
      when :integer
        return nil if setting.blank?
        return setting.to_i
      when :boolean        
        return (setting == 't')
      else
        return setting
      end

    end

    def set_inline_setting(key, value)
      raise ArgumentError unless key.is_a?(Symbol)
      raise ArgumentError.new("Unknown key: #{key}") unless self.class.inline_settings_fields[key]

      settings_field = send(self.class.inline_settings_field_name)
      settings_field = {} if settings_field.nil?
      settings_field[key.to_s] = value

      send("#{self.class.inline_settings_field_name}=", settings_field)
    end

  end
end