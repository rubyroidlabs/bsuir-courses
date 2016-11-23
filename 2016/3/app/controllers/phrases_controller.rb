WORD_REGEX = /^[^[.\s]]?\w+[^[.\s]]?$/

# class PhraseController
class PhrasesController < ApplicationController
  get "/phrases/new" do
    slim :new_phrase
  end

  post "/phrases/new" do
    if word_validate params[:first_word]
      phrase = Phrase.create(body: params[:first_word])
      Update.create(word: params[:first_word], prev_phrase: "", user_id: session[:user_id], phrase_id: phrase.id)
      redirect_to_home_page
    else
      redirect to "phrases/new"
    end
  end

  get "/phrases/edit/:id" do
    @phrase = Phrase.find(params[:id])
    @updates = pretty_updates(@phrase)
    slim :edit_phrase
  end

  post "/phrases/edit/:id" do
    if word_validate params[:word]
      phrase = Phrase.find(params[:id])
      Update.create(word: params[:word], prev_phrase: phrase.body, user_id: session[:user_id], phrase_id: phrase.id)
      Phrase.update(params[:id], body: phrase.body + " " + params[:word])
      redirect_to_home_page
    else
      redirect to "/phrases/edit/#{params[:id]}"
    end
  end

  helpers do
    def word_validate(word)
      word =~ WORD_REGEX
    end

    def pretty_updates(phrase)
      updates = phrase.updates
      result = []
      updates.each do |update|
        current_first_name = User.find(update.user_id).first_name
        result << %(#{current_first_name} (#{update.updated_at}): "#{update.prev_phrase} <b>#{update.word}</b>")
      end
      result
    end
  end
end
