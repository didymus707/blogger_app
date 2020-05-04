class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
   
    if @article.update(article_params)
      flash.notice = "Article '#{@article.title}' Updated!"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def create
    @article = Article.new(article_params)
    @article.save

    flash.notice = "Article '#{@article.title}' created!"
    redirect_to @article
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash.notice = "Delete Successful!"
    redirect_to articles_path(@articles)
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :tag_list)
  end
end
