# Model additions
module Templatar
  module ModelAdditions
    def has_template
      raise StandardError.new("Cannot add has_template to a non-AR model") unless self.respond_to?(:column_names)

      self.send(:define_method, :template?) { @templatar }

      metaclass = class << self; self; end
      metaclass.send(:define_method, :template) do
        @@templatar_singleton ||= begin
          t = self.new
          t.instance_variable_set :@templatar, true
          t_metaclass = class << t; self; end
          self.column_names.each do |column|
            t_metaclass.send(:define_method, column) { column == 'id' ? '$ID$' : "#{column}$TEMPLATE$" }
          end
          t
        end
      end
    end
  end
end
