module Castle
  module CastleClient
    def castle
      @castle ||= env['castle'] || Castle::Client.new(request, response)
    end
  end

  ActiveSupport.on_load(:action_controller) do
    include CastleClient
  end
end
