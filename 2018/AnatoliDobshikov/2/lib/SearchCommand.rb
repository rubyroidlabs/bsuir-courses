# Here we will search for something in somewhere and we would hope that we can find something really cool
require 'pg'
require 'active_record'
require 'json'
require_relative 'model/Request'
require_relative 'RepoCommandExtension'

class SearchCommand < RepoCommandExtension
  def reply
    # check if repo is available
    error_message = initialize_repo(@user.current_repo)
    if @repo.nil?
      return "#{error_message}\nPlease, set the available repository."
    end
    # ask to input search query
    unless @user.last_command == '/search'
      @user.update(last_command: '/search')
      return 'Input search query:'
    end
    # listing the results
    @request = Request.find_by(user_id: @user.id, active: true)
    # if user has active requests
    unless @request.nil?
      # end dialog
      if @message.text == '/ok'
        @user.update(last_command: 'none')
        @request.update(active: false)
        return 'I hope you found something useful.'
      end
      # page listing
      @search_results = search(@request[:query])
      page_number = @message.text.delete('/').to_i
      case page_number
      when 1..(@search_results['items'].length / 3)
        return print_page(page_number)
      else
        return "Cannot find this page. Type '/ok' to end search. Type '/{page_number}' to view page(/5 for example)."
      end
    end
    # process new query
    @search_results = search(@message.text)
    # add request to DB
    @request = Request.create(query: @message.text, repository: @user.current_repo, user_id: @user.id, active: true)
    return "I have found #{@search_results['total_count']} result(s).\n#{print_page(1)}"
  end

  private
  # create query for http GET
  def create_query(query_text = String.new)
    "repo:#{@user.current_repo}+#{query_text.split(' ').join('+')}"
  end
  # search in github commits
  def search(query_text = String.new)
    query = create_query(query_text)
    # search via github api
    search_text = %x`curl -H 'Accept: application/vnd.github.cloak-preview+json' \
    -i https://api.github.com/search/commits?q=#{query}`
    # select JSON from response
    search_text = search_text.slice(search_text.index('{')..(search_text.length - 1))
    JSON.parse(search_text)
  end
  # list the search results
  def print_page(page_number = 1)
    # header
    page = "Searching for #{@request.query} in #{@request.repository}.\n"
    page += "Page /#{page_number} of /#{@search_results['items'].length / 3} (three items per page):\n#{'=' * 30}\n"
    item_number = (page_number - 1) * 3 + 1
    # body XD
    3.times do
      if item_number > @search_results['items'].length
        return "#{page}\nThis is the last page. Type /ok to end search dialog, if you want.\n#{'=' * 30}\n"
      end
      commit_message = (@search_results['items'][item_number - 1]['commit']['message']).split("\n").join('. ')
      # cut long messages
      if commit_message.length > 100
        commit_message = commit_message.slice(0..96) + '...'
      end
      page += "#{item_number}. Link: #{@search_results['items'][item_number - 1]['html_url']}\nMessage: #{commit_message}\n#{'=' * 30}\n"
      item_number += 1
    end
    page
  end
end
