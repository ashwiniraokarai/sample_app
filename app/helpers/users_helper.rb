module UsersHelper
  # def gravatar_for(user, options = { size: 50 })
    # size = options[:size]
  #replacing has with keyword argument
  def gravatar_for(user, options = { size: 50 })
    size = options[:size]
    gravatar_id = Digest::MD5::hexdigest(user.email.strip.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name)
  end
end
