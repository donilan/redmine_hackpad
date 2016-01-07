Redmine::Plugin.register :redmine_hackpad do
  name 'Redmine Hackpad plugin'
  author 'Doni Leong'
  description 'Redmine plugin for include hackpad content into your wiki page by use macro.'
  version '0.0.2'
  url 'https://github.com/donilan/redmine_hackpad'
  author_url 'https://github.com/donilan'

  Redmine::WikiFormatting::Macros.register do
    desc "render hackpad content.\n"
    macro :hackpad do |obj, args|
      Hackpad.render_hackpad(args[0])
    end
  end
end
