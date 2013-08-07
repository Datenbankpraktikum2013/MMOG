class AlliancesController < ApplicationController
  before_action :set_alliance, only: [:show, :edit, :update, :destroy, :useradd, :user_add_action, :change_default_rank, :change_user_rank, :remove_user, :change_description, :send_mail]
  before_filter :authenticate_user!

  # GET /alliances
  # GET /alliances.json
  def index
    if current_user.alliance_id==nil
      @alliance = Alliance.new
    else
      @alliance = current_user.alliance
      redirect_to @alliance
    end
  end

  def send_mail
    @subj='[Allianznachricht] '+params['subject']
    @body=params['body']
    respond_to do |format|
      if @alliance.send_mass_mail(current_user,@subj,@body)
        format.html { redirect_to @alliance, notice: 'Rundmail wurde erfolgreich versendet.' }
        format.json { render action: 'show', status: :created, location: @alliance }
      else
        format.html { redirect_to @alliance, notice: 'Rundmail konnte nicht versendet werden.' }
        format.json { render json: @alliance.errors, status: :unprocessable_entity }
      end
    end    
  end

    # PATCH/PUT /alliances/1/edit/change_default_rank
  def change_default_rank
    @rank=@alliance.ranks.find_by_id(params['rank']['id'])
    respond_to do |format|
      if @alliance.change_default_rank(@rank)
        format.html { redirect_to @alliance, notice: 'Standardrang erfolgreich geändert!.' }
        format.json { render action: 'show', status: :created, location: @alliance }
      else
        format.html { redirect_to @alliance, notice: 'Standardrang konnte nicht geändert werden.' }
        format.json { render json: @alliance.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_description
    respond_to do |format|
      if @alliance.set_description(params['description'])
        format.html { redirect_to @alliance, notice: "Beschreibung erfolgreich geändert" }
        format.json { render action: 'show', status: :created, location: @alliance }
      else
        format.html { redirect_to @alliance, notice: "Konnte Beschreibung nicht ändern" }
        format.json { render json: @alliance.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_user_rank
    @rank=@alliance.ranks.find_by_id(params['rank']['id'])
    @user=@alliance.users.find_by_id(params['uid'])
    respond_to do |format|
      if @alliance.change_user_rank(@user,@rank)
        format.html { redirect_to @alliance, notice: @user.username+" wurde erfolgreich dem Rang "+@rank.name+" zugeordnet." }
        format.json { render action: 'show', status: :created, location: @alliance }
      else
        format.html { redirect_to @alliance, notice: @user.username+" konnte dem Rang "+@rank.name+" nicht zugeordnet werden." }
        format.json { render json: @alliance.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /alliances/1
  # GET /alliances/1.json
  def show
    @founder=@alliance.ranks.where(:is_founder=>true)[0].users[0]
  end

  # GET /alliances/new
  def new

  end

  # GET /alliances/1/edit
  def edit
  end

  # POST /alliances/1/edit/user_add_action
  def user_add_action
    @users=User.all
    @concrete_user=@users.where('username == ?',params['username']).first
    if validate_useradd(@concrete_user)==0
      respond_to do |format|
        if @alliance.add_user(@concrete_user) #save both
            format.html { redirect_to @alliance, notice: 'User has been successfully added.' }
            format.json { render action: 'edit', status: :created, location: @alliance }
        else
          format.html { redirect_to @alliance, notice: 'User could not be added.' }
          format.json { render json: @alliance.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to @alliance, notice: 'User could not be added.' }
        format.json { render json: @alliance.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_user
    @user=@alliance.users.find_by_id(params['uid'])
    respond_to do |format|
      if @alliance.remove_user(@user)
        format.html { redirect_to @alliance, notice: @user.username+" wurde aus der Allianz entfernt" }
        format.json { render action: 'show', status: :created, location: @alliance }
      else
        format.html { redirect_to @alliance, notice: @user.username+" konnte nicht aus der Allianz entfernt werden" }
        format.json { render json: @alliance.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /alliances
  # POST /alliances.json
  def create
    #only do if user has no alliance.
    if current_user.alliance_id==nil
      @alliance = Alliance.new(alliance_params)
      respond_to do |format|
        if @alliance.save and @alliance.set_founder(current_user) #save both
            format.html { redirect_to @alliance, notice: 'Alliance was successfully created.' }
            format.json { render action: 'show', status: :created, location: @alliance }
        else
          format.html { render action: 'new' }
          format.json { render json: @alliance.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  #GET  /alliances/1/edit/useradd
  def useradd
  end

  # PATCH/PUT /alliances/1
  # PATCH/PUT /alliances/1.json
  def update
    respond_to do |format|
      if @alliance.update(alliance_params)
        format.html { redirect_to @alliance, notice: 'Alliance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @alliance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alliances/1
  # DELETE /alliances/1.json
  def destroy
    #only if current user is founder
    if @alliance.user==current_user
      #cancel all alliance members
      @alliance.users.each do |user|
        user.alliance=nil
        user.save
      end
      @alliance.destroy
    end
    #response
    respond_to do |format|
      format.html { redirect_to alliances_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alliance
      @alliance = Alliance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alliance_params
      params.require(:alliance).permit(:name, :default_rank, :description)
    end

    def validate_useradd(user)
      if user==nil
        return 1 #user does not exist
      elsif user==current_user
        return 2 #user cant add himself
      elsif user.alliance!=nil
        return 3 #user already has an alliance
      elsif user.alliance==@alliance
        return 4 #user is already part of this alliance
      else
        return 0
      end
    end
end