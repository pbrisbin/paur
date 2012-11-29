require 'net/https'
require 'nokogiri'
require 'uri'

module Paur
  class Submission
    AUR    = 'aur.archlinux.org'
    LOGIN  = '/login'
    SUBMIT = '/submit'

    CREDENTIALS = {
      'user'        => ENV['AUR_USERNAME'],
      'passwd'      => ENV['AUR_PASSWORD'],
      'remember_me' => 1
    }

    def initialize
      http = Net::HTTP.new(AUR, 443)
      http.use_ssl = true

      res = http.post(LOGIN, parameterize(CREDENTIALS))
      @cookie = res['Set-cookie'] or raise 'Authentication failed'

      res  = http.get(SUBMIT, 'Cookie' => @cookie)
      html = Nokogiri::HTML(res.body)

      @token      = parse_token(html)      or raise 'Unable to parse token'
      @categories = parse_categories(html) or raise 'Unable to parse categories'
    end

    def command_for(file, category)
      cid = @categories[category] or raise 'Invalid category'

      [
        '/usr/bin/curl',
        '-#',
        '-H', 'Expect:',
        '-H', "'Cookie: #{@cookie}'",
        '-F', "token=#{@token}",
        '-F', "category=#{cid}",
        '-F', "pfile=@#{file}",
        '-F', 'pkgsubmit=1',
        "'https://#{AUR}#{SUBMIT}'"
      ].join(' ')
    end

    private

    def parameterize(params)
      URI.escape(params.map{ |k,v| "#{k}=#{v}" }.join('&'))
    end

    def parse_token(html)
      html.css('input[name=token]').first.attributes['value'].value
    end

    def parse_categories(html)
      html.css('select[name=category]').children.each_with_object({}) do |o,h|
        name  = o.children.to_s
        value = o.attributes['value'].value.to_i

        h[name] = value unless name == 'Select Category'
      end
    end
  end
end
