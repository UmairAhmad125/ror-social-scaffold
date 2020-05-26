module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def friends_check(user)
    return true if Friendship.where(user_id: current_user.id, friend_id: user.id, confirmed: true) || Friendship.where(user_id: user.id, friend_id: current_user.id, confirmed: true)
  end
  
  def accept_friend(friendship)
    link_to('Accept', update_friend_user_path(id: friendship.id), method: :patch)
  end

  def reject_friend(friendship)
    link_to('Decline', destroy_friend_user_path(id: friendship.id), method: :delete)
  end
end
