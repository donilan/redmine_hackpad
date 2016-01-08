class Hackpad
  CLIENT_ID = 'HACKPAD_CLIENT_ID'
  SECRET = 'HACKPAD_SECRET'
  SITE = 'HACKPAD_SITE'
  class << self
    def enabled?
      errors.empty?
    end

    def client_id
      Setting.plugin_redmine_hackpad[CLIENT_ID.downcase] || ENV[CLIENT_ID]
    end

    def secret
      Setting.plugin_redmine_hackpad[SECRET.downcase] || ENV[SECRET]
    end

    def site
      Setting.plugin_redmine_hackpad[SITE.downcase] || ENV[SITE]
    end

    def errors
      @errors = []
      @errors << "ENV #{CLIENT_ID} can't be empty please define it before Redmine start or plugin configuration page." if client_id.nil?
      @errors << "ENV #{SECRET} can't be empty please define it before Redmine start or plugin configuration page." if secret.nil?
      @errors << "ENV #{SITE} can't be empty please define it before Redmine start or plugin configuration page." if site.nil?
      @errors
    end

    def client
      OAuth::Consumer.new(client_id, secret, site: site)
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
