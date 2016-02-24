require 'i18n'
# require 'pry'


I18n.load_path += ['./locales/en.yml', './locales/ja.yml']

module Jekyll
  class TranslateTag < Liquid::Tag
    def initialize(tag_name, key, tokens)
      super
      @key = key
    end

    def render(context)
      lang = context.environments[0]['page']['language']
      I18n.locale = lang
      I18n.t @key.strip
#      binding.pry
    end
  end
end

Liquid::Template.register_tag('t', Jekyll::TranslateTag)
