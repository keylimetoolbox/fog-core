module Fog
  module Volume
    extend Fog::Core::ServiceAbstraction

    def self.new(attributes)
      attributes = attributes.dup # Prevent delete from having side effects
      provider = attributes.delete(:provider).to_s.downcase.to_sym
      if providers.include?(provider)
        require "fog/#{provider}/volume"
        return Fog::Volume.const_get(Fog.providers[provider]).new(attributes)
      end

      raise ArgumentError, "#{provider} has no identity service"
    end
  end
end
