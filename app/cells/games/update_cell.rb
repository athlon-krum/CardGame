# frozen_literal_error: true

module Games
  class UpdateCell < Cell::ViewModel
    include Escaped

    def show
      render :show
    end

    private

    def name
      escape!(contract.name)
    end

    def contract
      model
    end
  end
end
