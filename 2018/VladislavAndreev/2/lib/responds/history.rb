# frozen_string_literal: true

require_relative 'message_responder'

class HistoryResponder < MessageResponder
  def respond
    if history.empty?
      answer_with_message('История пуста')
    else
      text = []

      history.each { |row| text << row.query_text }

      answer_with_message("🗂 Исторя запросов: \n#{text.join("\n")}")
    end
  end

  private

  def history
    SearchRequest.where(user_id: @user.id).select('query_text')
  end
end
