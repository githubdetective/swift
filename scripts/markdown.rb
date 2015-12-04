require 'json'

module Info
    c = File.read 'swift-contributors-info.json'
    j = JSON.parse(c)

    fields = %w(username name location company followers public_repos created_at)

    m = ''
    fields.each do |f|
      m << "#{f} | "
    end
    m << "\n"

    fields.each do |f|
      m << "--- | "
    end
    m << "\n"

    j.each_with_index do |x,i|
      loc = x['location']
      co = x['company']
      fields.each do |f|
        puts f
        if f == 'username'
          m << "[#{x[f]}](https://github/com/#{x[f]}) | "
        else
          m << "#{x[f]} | "
        end
      end
      m << "\n"
    end

    File.write 'swift-contributors-info.md', m
end
