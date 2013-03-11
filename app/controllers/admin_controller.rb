class AdminController < ApplicationController
  def sign_up
  	@admin = Admin.new
  end

  def edit
    @admin = Admin.find(session[:adminID])
  end

  def update
    @admin = Admin.find(session[:adminID])

    @admin.name = params[:admin]["name"]
    @admin.username = params[:admin]["username"]

    if (params[:admin]["password"]!="")
      @admin.password = Digest::SHA1.hexdigest(params[:admin]["password"])
    end

    respond_to do |format|
      if @admin.save
        flash[:notice] = 'successfully updated.'
        session[:admin] = @admin.name

        format.html { redirect_to admin_edit_path, :notice =>"successfully updated." }
        format.json { head :no_content }
      else
        format.html { redirect_to admin_edit_path }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def createAdmin
  	@admin = Admin.new(params[:admin])
  	@admin.password = Digest::SHA1.hexdigest(@admin.password)

    respond_to do |format|
      if @admin.save
      	session[:admin] = @admin.name
        session[:adminID] = @admin.id
        format.html { redirect_to admin_path }
      else
        format.html { redirect_to admin_sign_up_path }
      end
    end

  end

  def log_in
    @admin = Admin.new
  end

  def loginCheck
  	@admin = Admin.new(params[:admin])
    @dbData = Admin.where("username = ?", @admin.username).first

    if(@dbData && pswordCheck(@admin.password, @dbData.password))
      session[:admin] = @dbData.name
      session[:adminID] = @dbData.id
      session[:notice] = nil
    else
      session[:notice] = "wrong password"
    end

    redirect_to admin_path
    
  end


  def log_out
    session[:admin] = nil
    redirect_to admin_path
  end

  private
  def pswordCheck(fromUser, fromDb)
    Digest::SHA1.hexdigest(fromUser) == fromDb
  end
end
