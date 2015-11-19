class RedmineHackpad
  CLIENT_ID = 'HACKPAD_CLIENT_ID'
  SECRET = 'HACKPAD_SECRET'
  SITE = 'HACKPAD_SITE'
  def self.enabled?
    errors.empty?
  end
  def self.errors
    @errors = []
    @errors << "ENV #{CLIENT_ID} can't be empty please define it before Redmine start." if ENV[CLIENT_ID].nil?
    @errors << "ENV #{SECRET} can't be empty please define it before Redmine start." if ENV[SECRET].nil?
    @errors << "ENV #{SITE} can't be empty please define it before Redmine start." if ENV[SITE].nil?
    @errors
  end
  def self.client
    @@client ||= OAuth::Consumer.new(ENV[CLIENT_ID], ENV[SECRET], site: ENV[SITE])
  end
  def self.content(pad_id, ext = 'html')
    client.request(:get, "/api/1.0/pad/#{pad_id}/content/latest.#{ext}").body
  end
end

Redmine::Plugin.register :redmine_hackpad do
  name 'Redmine Hackpad plugin'
  author 'Doni Leong'
  description 'Redmine plugin for include hackpad content into your wiki page by use macro.'
  version '0.0.1'
  url 'https://github.com/donilan/redmine_hackpad'
  author_url 'https://github.com/donilan'

  Redmine::WikiFormatting::Macros.register do
    desc "render hackpad content.\n"
    macro :hackpad do |obj, args|
      if RedmineHackpad.enabled?
        RedmineHackpad.content(args[0]).html_safe
      else
        msg = RedmineHackpad.errors.clone
        msg << "Please contact Admin if you saw this errors message!"
        msg.join(',')
      end
    end
  end
end
