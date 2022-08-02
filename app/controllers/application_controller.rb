class ApplicationController < ActionController::Base
  helper_method :get_avatar
  helper_method :get_username
  helper_method :already_requested
  helper_method :already_friended
  helper_method :get_friends
  
  def get_avatar(user)
    return url_for(user.avatar) if user.avatar.persisted?
    return 'default.webp'
  end

  def get_username(email)
    postfix = email.reverse.index("@") # find chars to left of @symbol
    username = email.slice(0, email.length - postfix - 1)
    return username
  end

  def already_requested(sender, receiver)
    request = FriendRequest.where(:friend_1_id => sender, :friend_2_id => receiver)
    other_side = FriendRequest.where(:friend_2_id => sender, :friend_1_id => receiver)
    return !request.empty? || !other_side.empty?
  end

  def already_friended(sender, receiver)
    sender_friends = get_friends(sender)
    receiver_friends = get_friends(receiver)
    return sender_friends.include?(receiver) || receiver_friends.include?(sender)
  end

  def get_friends(user) 
    friendships = Friendship.where(:friend_id => user.id)
    return user.friends + friendships
  end

end
