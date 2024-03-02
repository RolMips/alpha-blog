module ApplicationHelper

def gravatar_for(user, options = { size: 80})
  hash = Digest::MD5.hexdigest(user.email)
  gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{options[:size]}"
  image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block")
end

end
