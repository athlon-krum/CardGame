# frozen_string_literal: true

class GamesController < ApplicationController
  def edit
    game = GamesPolicy::Scope.new(policy_context, Game).resolve.find(params[:id])

    raise CardGameError::NotAuthorized unless GamesPolicy.new(policy_context, game).edit?

    contract = Games::UpdateContract.new(game)

    respond_to do |format|
      format.html do
        render html: cell('games/update', contract).(:show)
      end
    end
  end

  def update
    game = GamesPolicy::Scope.new(policy_context, Game).resolve.find(update_params[:id])

    raise CardGameError::NotAuthorized unless GamesPolicy.new(policy_context).update?

    contract = Games::UpdateContract.new(game)

    result = Games::Update.call(contract, create_params)

    respond_to do |format|
      format.html do
        if result.success?
          render html: cell('games/update', contract.prepopulate!).(:success)
        else
          render html: cell('games/update', contract.prepopulate!).(:failure)
        end
      end
    end
  end

  def update_params
    params.require(:game)
  end
end
