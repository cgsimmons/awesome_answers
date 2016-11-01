module AnswersHelper
  def upvote_link(question)
    vote = question.votes.find_by(user: current_user)
    method = if vote.nil?
                      :post
                    elsif vote.is_up?
                      :delete
                    else
                      :patch
                    end

    path = if vote.nil?
      question_votes_path(question, vote: {is_up:true})
    else
      vote_path(vote, vote: {is_up: true})
    end

    link_to(
     fa_icon("arrow-up"), path, method: method,
     class: "vote-link #{vote&.is_up? ? 'vote-up': ''}"
     )

  end
  def downvote_link(question)
    vote = question.votes.find_by(user: current_user)
    method = if vote.nil?
                      :post
                    elsif vote.is_down?
                      :delete
                    else
                      :patch
                    end

    path = if vote.nil?
      question_votes_path(question, vote: {is_up:false})
    else
      vote_path(vote, vote: {is_up: false})
    end

    link_to(
     fa_icon("arrow-down"), path, method: method,
     class: "vote-link #{vote&.is_down? ? 'vote-down': ''}"
     )

  end

end
