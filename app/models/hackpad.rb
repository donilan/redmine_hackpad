class Hackpad
  CLIENT_ID = 'HACKPAD_CLIENT_ID'
  SECRET = 'HACKPAD_SECRET'
  SITE = 'HACKPAD_SITE'
  class << self
    def enabled?
      errors.empty?
    end
    def errors
      @errors = []
      @errors << "ENV #{CLIENT_ID} can't be empty please define it before Redmine start." if ENV[CLIENT_ID].nil?
      @errors << "ENV #{SECRET} can't be empty please define it before Redmine start." if ENV[SECRET].nil?
      @errors << "ENV #{SITE} can't be empty please define it before Redmine start." if ENV[SITE].nil?
      @errors
    end
    def client
      @@client ||= OAuth::Consumer.new(ENV[CLIENT_ID], ENV[SECRET], site: ENV[SITE])
    end
    def content(pad_id, ext = 'html')
      client.request(:get, "/api/1.0/pad/#{pad_id}/content/latest.#{ext}").body
    end

    def init_view
      view = ActionView::Base.new(ActionController::Base.view_paths, {})
      view.extend ApplicationHelper
      view
    end

    def view
      @@view ||= init_view
    end

    def render_hackpad(pid)
      view.render(:partial => 'hackpads/hackpad', :locals => {:pid => pid})
    end
  end
end
