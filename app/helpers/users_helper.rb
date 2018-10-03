module UsersHelper

	# Returns the Gravatar for the given user. size options added as extra exercise 
	# see chapter 7 listing 7.9 for original
	def gravatar_for(user, size: 80)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end
end
