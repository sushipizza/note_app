module ApplicationHelper
    def gravatar_for(user)
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=identicon"
        image_tag(gravatar_url, alt: user.username, class: "rounded-circle")
    end
end
