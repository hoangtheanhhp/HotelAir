class PhotosController < ApplicationController 
	def create
		@room = Room.find(params[:room_id])

		if params[:images]
			params[:images].each do |img|
				# require 'pry'; binding.pry
				@room.photos.create(image: img)
			end
		end	

		@photos = @room.photos
		redirect_back(fallback_location: request.referer, notice: "Saved......")
	end

	def destroy
		@photo = Photo.find(params[:id])
		@room = Room.find(@photo.room_id)

		@photo.destroy

		@photos = @room.photos
	end
end