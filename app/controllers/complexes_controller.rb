class ComplexesController < ApplicationController
  # GET /complexes
  # GET /complexes.xml
  def index
    @complexes = Complex.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @complexes }
    end
  end

  # GET /complexes/1
  # GET /complexes/1.xml
  def show
    @complex = Complex.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @complex }
    end
  end

  # GET /complexes/new
  # GET /complexes/new.xml
  def new
    @complex = Complex.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @complex }
    end
  end

  # GET /complexes/1/edit
  def edit
    @complex = Complex.find(params[:id])
  end

  # POST /complexes
  # POST /complexes.xml
  def create
    @complex = Complex.new(params[:complex])

    respond_to do |format|
      if @complex.save
        flash[:notice] = 'Complex was successfully created.'
        format.html { redirect_to(@complex) }
        format.xml  { render :xml => @complex, :status => :created, :location => @complex }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @complex.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /complexes/1
  # PUT /complexes/1.xml
  def update
    @complex = Complex.find(params[:id])

    respond_to do |format|
      if @complex.update_attributes(params[:complex])
        flash[:notice] = 'Complex was successfully updated.'
        format.html { redirect_to(@complex) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @complex.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /complexes/1
  # DELETE /complexes/1.xml
  def destroy
    @complex = Complex.find(params[:id])
    @complex.destroy

    respond_to do |format|
      format.html { redirect_to(complexes_url) }
      format.xml  { head :ok }
    end
  end
end
