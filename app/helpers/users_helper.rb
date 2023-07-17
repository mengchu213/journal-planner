module UsersHelper

    def profile_image(user, options = {})
        url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}"
        image_tag(url, alt: user.name, **options)
    end



end
