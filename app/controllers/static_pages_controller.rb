class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

	def about
	end

	def contact
		@message=Message.new
	end

	def browse
	end

end
