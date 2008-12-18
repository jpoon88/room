class DistrictsController < ApplicationController
  skip_before_filter :login_required
  
  def map
    @districts = District.find(:all, :order => ['title' ])
    render :layout => false
  end
  
  def map2
    @stores = Store.find(:all, :order => ['date_open'])
    @group = @stores.group_by { |s| s.year_open  }
   
    @stores_hash = Hash[*(@stores).collect {|v| [v.code,v]}.flatten]
    @stores_by_year = Hash.new
    @group.each { |k,v| @stores_by_year[k] = v.collect {|x| x.code }  }
    
    list = Store.find_by_sql("select year_open as year, min(lat) as sw_lat, min(lng) as sw_lng, max(lat) as ne_lat, max(lng) as ne_lng FROM stores group by year_open")

    @borders = Hash.new
    list.each { |item| @borders[item.year] = { 'ne' => [item.ne_lat.to_f, item.ne_lng.to_f], 'sw' => [item.sw_lat.to_f, item.sw_lng.to_f] }   } 



    @group_latlng = @group.map {|k,values| values.map { |v| {'code' => v['code'], 
                 'lat'=> v['lat'], 'lng'=> v['lng'] }}  }

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
