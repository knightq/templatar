# Model additions
module Templatar
  module ModelAdditions
    def has_template(options = {})
      raise StandardError.new('Cannot add has_template to a non-AR model') unless self.respond_to?(:column_names)

      self.send(:define_method, :template?) { @templatar }

      custom_methods = options.fetch(:methods, [])

      metaclass = class << self; self; end
      metaclass.send(:define_method, :template) do
        @templatar_singleton ||= begin
          t = self.new
          t.instance_variable_set :@templatar, true
          t_metaclass = class << t; self; end
          (self.column_names + custom_methods).each do |getter|
            t_metaclass.send(:define_method, getter) { getter.to_sym == :id ? '__ID__' : "#{getter}__TEMPLATE__" }
          end
          t
        end
      end
    end
  end
end
