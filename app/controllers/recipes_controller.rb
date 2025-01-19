class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy like unlike]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.all
  end

  def search
    @recipes = Recipe.all

    if params[:title_search].present?
      @recipes = @recipes.where("title ILIKE ?", "%#{params[:title_search]}%")
    end

    if params[:tag_ids].present?
      @recipes = @recipes
      .joins(:tags)
      .where(tags: {id: params[:tag_ids]})
      .group('recipes.id')
      .having('COUNT(tags.id) = ?', params[:tag_ids].length)
    end

    case params[:sort_by]
    when 'newest'
      @recipes = @recipes.order(created_at: :desc)
    when 'oldest'
      @recipes = @recipes.order(created_at: :asc)
    when 'title_asc'
      @recipes = @recipes.order(:title)
    when 'title_desc'
      @recipes = @recipes.order(title: :desc)
    else
      @recipes = @recipes.order(created_at: :desc)
    end
    
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("search_results", partial: "recipes/search_results", locals: {recipes: @recipes})
      end
    end
  end

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    #@recipe = Recipe.new
    @recipe = current_user.recipes.build
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes or /recipes.json
  def create
    #@recipe = Recipe.new(recipe_params)
    @recipe = current_user.recipes.build(recipe_params.except(:tags))
    create_or_delete_recipes_tags(@recipe, params[:recipe][:tags])

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    create_or_delete_recipes_tags(@recipe, params[:recipe][:tags])
    respond_to do |format|
      if @recipe.update(recipe_params.except(:tags))
        format.html { redirect_to @recipe, notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy!

    respond_to do |format|
      format.html { redirect_to recipes_path, status: :see_other, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @recipe = current_user.recipes.friendly.find(params.expect(:id))
    redirect_to recipes_path, notice: "Not Authorized To Edit This Recipe" if @recipe.nil?
  end

  def like
    current_user.likes.create(likeable: @recipe)
    render partial: "recipes/recipe", locals: { recipe: @recipe }
  end

  def unlike
    current_user.likes.find_by(likeable: @recipe).destroy
    render partial: "recipes/recipe", locals: { recipe: @recipe }
  end

  private

  def create_or_delete_recipes_tags(recipe, tags)
    recipe.taggables.destroy_all  
    
    tags = tags.strip.split(",").map(&:strip).map(&:downcase)
    tags.each do |tag|
      recipe.tags << Tag.find_or_create_by(name: tag.capitalize)
    end
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.friendly.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.expect(recipe: [ :title, :ingredients, :user_id, :image, :tags, :content])
    end
end
