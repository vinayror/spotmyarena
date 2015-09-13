  class GroundsController < ApplicationController
    before_action :authenticate_user! , except: [:search]
    load_resource only: [:show, :create ,:update, :destroy, :edit]
    PER_PAGE = 5
    def search
      @test = ""
      @test2 = ""
    	category = params[:category]
    	city = params[:city]
    	area = params[:area]
    	date = params[:date].to_date
    	@grounds = Kaminari.paginate_array(Ground.search(category, city, area, date)).page(params[:page] || 1).per(PER_PAGE)

    end

    def index
      @grounds = current_user.grounds if current_user.present? #&& current_user.has_role? "ground_owner"

    end

    def show
      @slot = @ground.booking_dates.first.booking_times.map{|e| e.slot}
    end

    # GET /grounds/new
    def new
      @ground = Ground.new
      #@ground_attachment = @ground.ground_attachments.build
    end

    # GET /grounds/1/edit
    def edit
        
    end

    # POST /grounds
    # POST /grounds.json
    def create
      @ground = Ground.new(ground_params)
      @ground.user = current_user if current_user.has_role? :ground_owner


      respond_to do |format|
        if @ground.save
          # params[:ground_attachments]['photo'].each do |p|
          #   @ground_attachment = @ground.ground_attachments.create!(:photo => p) if p.present
          # end
          format.html { redirect_to @ground, notice: 'ground was successfully added.' }
          format.json { render :show, status: :created, location: @ground }
        else
          format.html { render :new }
          format.json { render json: @ground.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /grounds/1
    # PATCH/PUT /grounds/1.json
    def update
      respond_to do |format|
        if @ground.update(ground_params)
          format.html { redirect_to @ground, notice: 'ground was successfully updated.' }
          format.json { render :show, status: :ok, location: @ground }
        else
          format.html { render :edit }
          format.json { render json: @ground.errors.messages, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /grounds/1
    # DELETE /grounds/1.json
    def destroy
      if @ground.destroy
        respond_to do |format|
          format.html { redirect_to grounds_url, notice: 'ground was successfully destroyed.' }
          format.json { head :no_content }
        end
      end
    end

    

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_ground
        @ground = ground.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def ground_params
        params.require(:ground).permit(:name, :city, :area, :pincode, :address, :status, :category, :weekend_price, :weekday_price, :court, :phone, :attention_message , booking_dates_attributes: [:id, :date_of_booking, :status, :ground_id, :_destroy, booking_times_attributes: [:id, :time_of_booking, :status, :booking_date_id, :timeslot_id, :_destroy]], ground_attachments_attributes: [:id, :ground_id, :photo, :_destroy])
      end

  end
