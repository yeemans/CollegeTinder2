class UsersController < ApplicationController
  before_action :authenticate_user!
  def show  

  end 
  
  def profile 
    @user = current_user
    @user = User.find(params[:id]) if params[:id]
    @username = get_username(@user.email)
    @avatar = get_avatar(@user)
    @friends = @user.friends
    @requested_or_friended = current_user.friends.include?(@user) || already_requested(current_user.id, @user.id)
    @people_to_check_out = User.all.last(3)
  end

  def match 

  end

  def notifications 
    @user = current_user
    @requests = FriendRequest.where(:friend_2_id => @user.id)
    @pending_requests = FriendRequest.where(:friend_1_id => @user.id)
  end

  def update 
    @user = current_user 
    @user.year = params[:user][:year] 
    @user.college = params[:user][:college]
    @user.major = params[:user][:major]
    @user.save!
    
    respond_to do |format| 
      format.html {redirect_to root_path }
    end 
  end

  def change_avatar 
    @user = current_user 
    @user.avatar = params[:user][:avatar]
    @user.save!
    
    respond_to do |format| 
      format.html { redirect_to root_path }
    end
  end

  def send_request 
    return if already_requested(params[:sender_id], params[:receiver_id])
    FriendRequest.create(:friend_1_id => params[:sender_id], 
                         :friend_2_id => params[:receiver_id])
    flash[:request_success] = "Your friend request was sent"
    respond_to do |format| 
      # receiver_id is the person who got the request
      format.html {redirect_to profile_path(params[:receiver_id])}
      format.js { }
    end
  end

  def accept_request 
    # create the friendship, then delete the request
    # check if friendship exists
    @request = FriendRequest.find(params[:request_id])
    @request.delete 
    @sender = User.find(@request.friend_1_id)
    @receiver = User.find(@request.friend_2_id)
    
    if !already_friended(@sender, @receiver)
      #@friendship = Friendship.create(:user_id => @request.friend_1_id, :friend_id => @request.friend_2_id)
      #@friendship.save!
      @receiver.befriend(@sender)
    end

    # friend_2_id is the user who accepted the request
    redirect_to profile_path(@request.friend_2_id) 
  end

  def decline_request 
    # create the friendship, then delete the request
    @request = FriendRequest.find(params[:request_id])
    @request.delete
    # friend_2_id is the user who accepted the request
    redirect_to profile_path(@request.friend_2_id) 
  end

  def message
    @user = User.find(params[:id])
    @current_user = current_user
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    @room = Room.new
    @message = Message.new
    @room_name = get_name(@user, @current_user)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @current_user],     
                   @room_name)
    @messages = @single_room.messages
    render "rooms/index"
  end 

  def conversations 
    @chats = get_private_chats(current_user)
    @receivers = []
    @chats.each { |chat| @receivers.append( get_receiver(chat) ) }
  end

  private
  def get_name(user1, user2)
    users = [user1, user2].sort
    "private_#{users[0].id}_#{users[1].id}"
  end

  def get_private_chats(user)
    @rooms = Room.where(is_private: true)
    @rooms_with_user = []

    @rooms.each do |r| 
      @participants = [User.find( r.participants[0].user_id ), User.find( r.participants[1].user_id ) ]
      @rooms_with_user.append(r) if @participants.include?(user)
    end

    return @rooms_with_user
  end

  def get_receiver(room)
    @participants = room.participants
    talking_to_self = @participants[0].user_id == @participants[1].user_id
    return User.find(@participants[0].user_id) if talking_to_self
    @participants.each {|p| return User.find(p.user_id) if p.user_id != current_user.id }    
  end

end
