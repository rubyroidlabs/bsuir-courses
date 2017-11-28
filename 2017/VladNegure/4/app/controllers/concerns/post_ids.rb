module PostIds
  extend ActiveSupport::Concern

  private

  def set_post_id_session
    session[:post_ids] = []
  end

  def add_post_id
    set_post_id_session if session[:post_ids].nil?
    session[:post_ids] << @post.id
  end

  def remove_post_id
    session[:post_ids].delete(@post.id) if session[:post_ids].nil?
  end
end
