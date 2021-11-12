require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

describe Movie do
  describe 'searching Tmdb by keyword' do
    it 'calls Faraday gem with CS169 domain' do
      expect(Faraday).to receive(:get).with('https://cs169.org')
      Movie.find_in_tmdb('https://cs169.org')
    end
  end
end