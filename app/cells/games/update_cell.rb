# frozen_literal_error: true

module Games
  class UpdateCell < Cell::ViewModel
    include Escaped

    def show
      render :show
    end

    def success
      content_tag(:p, style: 'background-color: green') do
        'You have successfully updated the game'
      end + show.html_safe
    end

    def failure
      content_tag(:p, style: 'background-color: red') do
        %(
          #{pluralize(contract.errors.count, 'Error')} occured when saving the game:
          #{contract.errors.full_messages.to_sentence}
        )
      end + show.html_safe
    end

    private

    def name
      escape!(contract.model.name)
    end

    def contract
      model
    end
  end
end
