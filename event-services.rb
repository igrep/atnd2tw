require 'uri'
require 'open-uri'
require 'rubygems'
require 'json/pure'

module EventServices
  # Maybe useful for other web services
  EVENTS     = 'events'.freeze
  USERS      = 'users'.freeze
  TWITTER_ID = 'twitter_id'.freeze

  # module_function could have a bad effect when included.
  class << self
    def event2twitter_ids service_name, event_id
      __send__ service_name, event_id
    end

    def atnd event_id
      #see http://api.atnd.org
      JSON.parse(
        OpenURI.open_uri(
          "http://api.atnd.org/events/users/?event_id=#{ event_id }&format=json"
        ).read
      )[ EVENTS ][0][ USERS ].map{|usr| usr[ TWITTER_ID ] }.compact
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  require 'pp'
  # Don't think deeply why I chose this event.
  # Completely no relation to me!
  pp EventServices.event2twitter_ids( :atnd, '4' )
end
