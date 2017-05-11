class ArticlesController < ApplicationController

	#GET /articles
	def index
		#Obtiene Todos los registro de la tabla
		@articles = Article.all
	end

	#GET /articles/:id
	def show
		#Encontrar los registro por id
		@article = Article.find(params[:id])
	end

	#GET /articles/new
	def new
		@article = Article.new
	end

	#POST /articles
	def create
		@article = Article.new(article_params)

		if @article.save
			redirect_to @article
		else
			render :new #Estudiar esto
		end

		
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
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
		@article = Article.find(params[:id])
	end

	private

	def article_params
		params.require(:article).permit(:title, :body)
	end
end