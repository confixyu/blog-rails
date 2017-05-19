class ArticlesController < ApplicationController
	
	before_action :authenticate_user!, except: [:show, :index]
	before_action :set_article, except: [:index, :new, :create]

	#GET /articles
	def index
		#Obtiene Todos los registro de la tabla
		@articles = Article.all
	end

	#GET /articles/:id
	def show
		#Encontrar los registro por id
		#@article = Article.find(params[:id])

		@article.update_visits_count
		@comment = Comment.new
	end

	#GET /articles/new
	def new
		@article = Article.new
	end

	#POST /articles
	def create
		@article = current_user.articles.new(article_params)

		if @article.save
			redirect_to @article
		else
			render :new 
		end
	end
		
	

	def destroy
		
		@article.destroy #eliminar el objeto de BD
		redirect_to articles_path
		
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			rendirect_to @article_params
		else
			render :edit
		end
	end

	def edit
		#@article = Article.find(params[:id])
	end

	private

	def set_article
		@article = Article.find(params[:id])
	end

	def validate_user
		redirect_to new_user_session_path, notice: "Necesitas iniciar sessión"
	end

	def article_params
		params.require(:article).permit(:title, :body)
	end
end