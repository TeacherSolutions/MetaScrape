class ScrapesController < ApplicationController
  http_basic_authenticate_with name: "scrape", password: "me", except: :index

  before_action :set_scrape, only: [:show, :edit, :update, :destroy]

  # GET /scrapes
  # GET /scrapes.json
  def index
    @scrapes = Scrape.all
  end

  # GET /scrapes/1
  # GET /scrapes/1.json
  def show
    if !@scrape
      redirect_to new_scrape_path(params)
    end
  end

  # GET /scrapes/new
  def new
    @scrape = Scrape.new
    if params[:id]
      @scrape.url = params[:id].gsub("!",".").gsub("_","/").gsub("%","-").gsub("xSECx","ssl ")
    end
  end

  # GET /scrapes/1/edit
  def edit
  end

  # POST /scrapes
  # POST /scrapes.json
  def create
    @scrape = Scrape.new(scrape_params)

    page = MetaInspector.new(scrape_params[:url])

    if page
      if page.title
        @scrape.title = page.title
      end
      if page.description
        @scrape.description = page.description
      end
    end

    opengraph = OpenGraph.fetch(scrape_params[:url])
    if opengraph

      if opengraph.page_type
        @scrape.page_type = opengraph.type
      end
      if opengraph.image
        @scrape.image = opengraph.image
      end
      if opengraph.locale
        @scrape.locale = opengraph.locale
      end
      if opengraph.site_name
        @scrape.site_name = opengraph.site_name
      end
    end

    #forgive me..
    @scrape.url = page.url.gsub("www.","").gsub("https://","xSECx").gsub("http://","").gsub(".","!").gsub(":","").gsub("/","_").gsub("-","%")

    respond_to do |format|
      if @scrape.save
        format.html { redirect_to @scrape, notice: 'Scrape was successfully created.' }
        format.json { render :show, status: :created, location: @scrape }
      else
        format.html { render :new }
        format.json { render json: @scrape.errors, status: :unprocessable_entity }
      end
    end

  rescue
    render :show, notice: "Failed to scrape that URL."
  end

  # PATCH/PUT /scrapes/1
  # PATCH/PUT /scrapes/1.json
  def update
    respond_to do |format|
      if @scrape.update(scrape_params)
        format.html { redirect_to @scrape, notice: 'Scrape was successfully updated.' }
        format.json { render :show, status: :ok, location: @scrape }
      else
        format.html { render :edit }
        format.json { render json: @scrape.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scrapes/1
  # DELETE /scrapes/1.json
  def destroy
    @scrape.destroy
    respond_to do |format|
      format.html { redirect_to scrapes_url, notice: 'Scrape was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scrape
      @scrape = Scrape.find_by_url(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scrape_params
      params.require(:scrape).permit(:url, :title, :description, :page_type, :image, :locale, :site_name)
    end
end
