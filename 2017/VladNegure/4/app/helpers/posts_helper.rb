module PostsHelper
  def operation(post)
    case post.operation
    when 'sell'
      'Selling'
    when 'buy'
      'Buying'
    when 'both'
      'Selling and buying'
    else
      'Oops something went wrong'
    end
  end

  def can?(post)
    return false if session[:post_ids].nil?
    session[:post_ids].include? post.id
  end
end
