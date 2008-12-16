class DistrictsController < ApplicationController
  skip_before_filter :login_required
  
  def map
    @districts = District.find(:all, :order => ['title' ])
    render :layout => false
  end
  
  def map2
    @stores = Store.find(:all, :order => ['code'])
    @group = @stores.group_by { |s| s.date_open.year  }
    
    render :layout => false
  end
  
  # GET /districts
  # GET /districts.xml
  def index
    @districts = District.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @districts }
      format.js {
         h = Hash.new;
         @districts.each { |c| h[c.code] = { 'code' => c.code, 'title' => c.title }  }
         @some_json = h.to_json
      }
    end
    

#result = @districts.map{ |c| { c.id  => { 'code' => c.code, 'title' => c.title } }  }  
#render :js => '<script> var dist = ' + result.to_json + '</script>'    
  end

  # GET /districts/1
  # GET /districts/1.xml
  def show
    @district = District.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @district }
    end
  end

  # GET /districts/new
  # GET /districts/new.xml
  def new
    @district = District.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @district }
    end
  end

  # GET /districts/1/edit
  def edit
    @district = District.find(params[:id])
  end

  # POST /districts
  # POST /districts.xml
  def create
    @district = District.new(params[:district])

    respond_to do |format|
      if @district.save
        flash[:notice] = 'District was successfully created.'
        format.html { redirect_to(@district) }
        format.xml  { render :xml => @district, :status => :created, :location => @district }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @district.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /districts/1
  # PUT /districts/1.xml
  def update
    @district = District.find(params[:id])

    respond_to do |format|
      if @district.update_attributes(params[:district])
        flash[:notice] = 'District was successfully updated.'
        format.html { redirect_to(@district) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @district.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /districts/1
  # DELETE /districts/1.xml
  def destroy
    @district = District.find(params[:id])
    @district.destroy

    respond_to do |format|
      format.html { redirect_to(districts_url) }
      format.xml  { head :ok }
    end
  end
end
