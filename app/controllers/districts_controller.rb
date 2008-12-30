class DistrictsController < ApplicationController
  skip_before_filter :login_required
  
  def map
    @districts = District.find(:all, :order => ['title' ])
    render :layout => false
  end

  def country
    applestore
    
  end
  
  def applestore2
    applestore
    
  end

  def applestore
    # localhost:3000 API key 
    #<script src="http://maps.google.com/maps?file=api&v=2&key=ABQIAAAA3wAYtMpwXTd-PQv4ZpZRmhTJQa0g3IQ9GZqIMmInSLzwtGDKaBS2C5ay-CYTpdFcZWDGGOa1YCbeDA&sensor=false"
    #        type="text/javascript">
    #</script>
   
    
    # Notes: Dynamic data use to_json on the view 
    # <script type="text/javascript">
    # var stores = <%= @stores_hash.to_json %>;
    # var stores_by_year_month = <%=  @stores_by_year_month.to_json %>;
    # var counts_by_year_month = <%=  @counts_by_year_month.to_json %>;
    # var stores_by_year = <%=  @stores_by_year.to_json %>;
    # var counts_by_year = <%=  @counts_by_year.to_json %>;
    
    @stores = Store.find(:all, :order => "title")
    @group_by_country = @stores.group_by { |s| s.country  }
    
    @stores_hash = Hash[*(@stores).collect {|v| [v.code,v]}.flatten] 
    @group = @stores.group_by { |s| s.year_open.to_s + '-' + s.month_open.to_s  }
    # Value: Store ID only
    @stores_by_year_month = Hash.new
    @counts_by_year_month = Hash.new
    @group.map { |k,v| 
      @stores_by_year_month[k] = v.collect {|x| x.code }
      @counts_by_year_month[k] = v.size 
    }
    @max_count = @counts_by_year_month.values.max 
    @year_list = Store.find(:all, :select => 'year_open', :group => 'year_open', :order => 'year_open').map {|s| s.year_open}

    @group_by_year = @stores.group_by { |s| s.year_open  }
    @stores_by_year = Hash.new    
    @counts_by_year = Hash.new    
    @group_by_year.map { |k,v| 
      @stores_by_year[k] = v.collect {|x| x.code }
      @counts_by_year[k] = v.size
    }

    # recent year
    store = Store.maximum('date_open')
    @last_year_month = store.year.to_s + '-' + store.month.to_s
    #@count_by_year_month = Store.find_by_sql("SELECT year_open, month_open, count(*) as total FROM stores group by year_open, month_open order by year_open, month_open")
    #@max_count = @count_by_year_month.max {|b,c| b.total.to_i <=> c.total.to_i }.total.to_i
    #@max_count = (@max_count / 10.0).ceil * 10
    #@group_by_year_month = @count_by_year_month.group_by { |s| s.year_open.to_s + '-' + s.month_open.to_s  }
    #@group_by_year_month.map {|k,v| @group_by_year_month[k] = v[0].total.to_i }
    
    
     respond_to do |format|
        format.html { render :layout => false }
        format.js 
      end

    
  end
  
  def map2
    @stores = Store.find(:all, :order => ['title'])
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
