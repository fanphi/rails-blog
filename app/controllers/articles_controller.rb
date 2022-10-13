class ArticlesController < ApplicationController

  #before action läggs till tillsammans med private så att vi inte behöver upprepa methods
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:update, :edit, :destroy]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1 or /articles/1.json
  def show
    # debug
    # @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    # @article = Article.find(params[:id]) 
    # redirect_to edit_article_path
  end

  # POST /articles or /articles.json
  # utan private article_params
  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to @article 
    else
      render 'new'
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json

  #Med private article_params
  def update
    @article = Article.find(params[:id])
   if @article.update(article_params)
    flash[:notice] = "Article was updated successfully"
    redirect_to @article
   else
    render "edit"
   end
    # respond_to do |format|
    #   if @article.update(article_params)
    #     format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
    #     format.json { render :show, status: :ok, location: @article }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @article.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    # @article = Article.find(params[:id]) #Vi har lagt till set_article i private och kan därför ta bort denna rad
    @article.destroy
    redirect_to articles_path

    # respond_to do |format|
    #   format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
  #private ska alltid vara längst ner

    def set_article
      @article = Article.find(params[:id])
    end
 
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def require_same_user
      if current_user != @article.user
        flash[:alert] = "You can only edit or delete your own article"
        redirect_to @article
    end
  end

end
