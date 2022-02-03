class CampersController < ApplicationController

    #GET /campers
    def index
        render json: Camper.all, include: ['id', 'name', 'age'], status: :ok
    end

    #GET /campers/:id
    def show
        camper = Camper.find(params[:id])
        render json: camper, status: :ok
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Camper not found" }, status: :not_found
    end

    #POST /campers
    def create
        camper = Camper.create!(name: params[:name], age: params[:age])
        render json: camper, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
