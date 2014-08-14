module Templatar
  class Railtie < Rails::Railtie
    initializer 'templatar.model_additions' do
      ActiveSupport.on_load :active_record do
        extend ModelAdditions
      end
    end
  end
end