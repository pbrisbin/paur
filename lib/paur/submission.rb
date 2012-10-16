require 'net/https'
require 'nokogiri'
require 'uri'

module Paur
  class Submission
    AUR = 'https://aur.archlinux.org'

    CATEGORIES = {
      'daemons'    => 2,
      'devel'      => 3,
      'editors'    => 4,
      'emulators'  => 5,
      'games'      => 6,
      'gnome'      => 7,
      'i18n'       => 8,
      'kde'        => 9,
      'kernels'    => 19,
      'lib'        => 10,
      'modules'    => 11,
      'multimedia' => 12,
      'network'    => 13,
      'office'     => 14,
      'science'    => 15,
      'system'     => 16,
      'x11'        => 17,
      'xfce'       => 18
    }

    attr_reader :taurball, :category

    def initialize(taurball, category)
      @taurball = taurball or raise 'Taurball not present'
      @category = CATEGORIES[category] or raise 'Invalid category'
    end

    # POST to index an return the session cookie
    def cookie
      unless @cookie
        data = [
          "user=#{ENV['AUR_USERNAME']}",
          "passwd=#{ENV['AUR_PASSWORD']}",
          'remember_me=1'
        ].join('&')

        res = http.post('/index.php', data)
        @cookie = res['Set-cookie'] or raise 'Authentication failed'
      end

      @cookie
    end

    # GET the submission form and parse the hidden token input
    def token
      res  = http.get('/pkgsubmit.php', 'Cookie' => cookie)
      html = Nokogiri::HTML(res.body)
      html.css('input[name=token]').first.attributes['value'].value or raise 'Unable to parse token'
    end

    # Return a curl command suitible for upload
    def submit_command
      [
        '/usr/bin/curl',
        '-#',
        '-H', 'Expect:',
        '-H', "'Cookie: #{cookie}'",
        '-F', 'pkgsubmit=1',
        '-F', "token=#{token}",
        '-F', "category=#{category}",
        '-F', "pfile=@#{taurball}",
        "'#{AUR}/pkgsubmit.php'"
      ].join(' ')
    end

    private

    def http
      uri = URI.parse(AUR)

      Net::HTTP.new(uri.host, 443).tap do |http|
        http.use_ssl = true
      end
    end
  end
end
