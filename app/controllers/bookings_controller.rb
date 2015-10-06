class BookingsController < ApplicationController
  before_action :authenticate_user! #, except: [:search]
  load_resource only: [:show, :create ,:update, :destroy, :edit]
  PER_PAGE = 5


  def index
    @bookings = BookingTime.where(person_id: current_user.id)
  end

  def show
  end

  # GET /grounds/new
  def new
    @booking = Booking.new
  end

  # GET /grounds/1/edit
  def edit
      
  end

  # POST /grounds
  # POST /grounds.json
  def create
    @booking = booking.new(booking_params)
    @booking.user = current_user if current_user.has_role? :member
    

    respond_to do |format|
      if @booking.save

        # params[:ground_attachments]['photo'].each do |p|
        #   @booking_attachment = @booking.ground_attachments.create!(:photo => p)
        # end
        format.html { redirect_to @booking, notice: 'Booking created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grounds/1
  # PATCH/PUT /grounds/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors.messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grounds/1
  # DELETE /grounds/1.json
  def destroy
    if @booking.destroy
      respond_to do |format|
        format.html { redirect_to grounds_url, notice: 'Booking was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def request_for_cancel
    slot_id = params[:slot_id].to_i
    slot = BookingTime.find(params[:slot_id].to_i)
    slot.update(cancelation_status: "requested for cancelation")
    ground_id = slot.ground_details.id
    CancelBooking.create(user_id: current_user.id, ground_id: ground_id, booking_time_id: slot_id, description: params[:reason])
    respond_to do |format|
      format.html { redirect_to bookings_path, notice: 'you are requested successfully.' }
      format.json { head :no_content }
    end
  end

  def payment_success
    @status = params[:status]
    @transaction_id = params[:txnid]
    @amount = params[:amount]
    @net_amount_debit = params[:net_amount_debit]
    @bank_ref_num = params[:bank_ref_num]
    @email = params[:email]
    Transaction.create(user_id: current_user.id, status: @status, transaction_id: @transaction_id, amount_debit: @net_amount_debit, bank_ref_num: @bank_ref_num)
    UserMailer.transaction_success(current_user, @transaction_id, @amount)
  end

  def payment_fail
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:user_id, :cancel, :slot_ids[])
    end

end
