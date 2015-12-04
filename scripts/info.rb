require 'octokit'
require 'netrc'
require 'json'

module Info
    c = File.read 'swift-contributors.json'
    j = JSON.parse(c)

    client = Octokit::Client.new(netrc: true)

    m = j.map do |x|
        puts "Getting info for #{x}"

        u = client.user x

        html_url = u['html_url']
        followers = u['followers']
        public_repos = u['public_repos']
        name = u['name']
        company = u['company']
        avatar_url = u['avatar_url']
        blog = u['blog']
        location = u['location']
        bio = u['bio']
        created_at = u['created_at']

        {
          username: x,
          name: name,
          company: company,
          location: location,
          bio: bio,
          html_url: html_url,
          avatar_url: avatar_url,
          followers: followers,
          public_repos: public_repos,
          created_at: created_at
        }
    end

    puts m

    json = m.to_json
    filename = 'swift-contributors-info.json'
    File.open(filename, 'w') { |f| f.puts(json) }
end
