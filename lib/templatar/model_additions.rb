module Templatar
  module ModelAdditions
    def has_template
      raise StandardError.new("Cannot add has_template to a non-AR model") unless self.respond_to?(:column_names)

      self.send(:define_method, :template?) do
        @templatar == true
      end

      metaclass = class << self; self; end
      metaclass.send(:define_method, :template) do
        @@templatar_singleton ||= begin
          t = self.new
          t.instance_variable_set :@templatar, true
          t_metaclass = class << t; self; end
          self.column_names.each do |column|
            t_metaclass.send(:define_method, column) do
              column == 'id' ? 'ID' : "#{column}_TEMPLATE"
            end
          end
          t
        end
      end
    end
  end
end
