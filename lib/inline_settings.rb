require 'inline_settings/configuration'
require 'inline_settings/base'

ActiveRecord::Base.class_eval do
  def self.inline_settings(*args, &block)
    InlineSettings::Configuration.new(*args.unshift(self), &block)
    include InlineSettings::Base
  end
end