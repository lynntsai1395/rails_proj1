class PokemonsController < ApplicationController
	def capture
		@pokemon = Pokemon.find(params[:id])
		@pokemon.trainer = current_trainer
		@pokemon.save
		redirect_to root_path
	end
	def damage
		@pokemon = Pokemon.find(params[:id])
		@pokemon.health -= 10
		if @pokemon.health <= 0
			@pokemon.destroy
		else
			@pokemon.save
		end
		redirect_to trainer_path(:id => @pokemon.trainer.id)
	end
	def new
		@pokemon = Pokemon.new
	end
	def create
		@pokemon = Pokemon.new(pokemon_params)
		@pokemon.trainer = current_trainer
		@pokemon.health = 100
		@pokemon.level = 1
		if @pokemon.save
			redirect_to trainer_path(:id => @pokemon.trainer.id)
		else
			flash[:error] = @pokemon.errors.full_messages.to_sentence
			redirect_to :back
		end
	end

	private
	def pokemon_params
		params.require(:pokemon).permit(:name)
	end
end
