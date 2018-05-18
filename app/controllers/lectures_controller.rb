class LecturesController < ApplicationController
  before_action :set_lecture, only: [:download, :show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /lectures
  # GET /lectures.json
  def index
    @lectures = Lecture.all
  end

  # GET /lectures/1
  # GET /lectures/1.json
  def show
  end

  # GET /lectures/new
  def new
    @lecture = Lecture.new
  end

  # GET /lectures/1/edit
  def edit
  end

  # POST /lectures
  # POST /lectures.json
  def create
    @lecture = Lecture.new(lecture_params)
    #save file to server
    uploaded_io = params[:lecture][:attachment]
     File.open(Rails.root.join('public','uploads',uploaded_io.original_filename),'wb') do |file|
    file.write(uploaded_io.read)
     end
    @lecture.attachment= uploaded_io.original_filename
      respond_to do |format|
      if @lecture.save
        format.html { redirect_to @lecture, notice: 'Lecture was successfully created.' }
        format.json { render :show, status: :created, location: @lecture }
      else
        format.html { render :new }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lectures/1
  # PATCH/PUT /lectures/1.json
  def update
    uploaded_io = params[:lecture][:attachment]
    File.open(Rails.root.join('public','uploads',uploaded_io.original_filename),'wb') do |file|
   file.write(uploaded_io.read)
    end
    params[:lecture][:attachment]= uploaded_io.original_filename

    respond_to do |format|

      if @lecture.update(lecture_params)
        
        format.html { redirect_to @lecture, notice: 'Lecture was successfully updated.' }
        format.json { render :show, status: :ok, location: @lecture }
      else
        format.html { render :edit }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lectures/1
  # DELETE /lectures/1.json
  def destroy
    @lecture.destroy
    respond_to do |format|
      format.html { redirect_to lectures_url, notice: 'Lecture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def comment
    @lecture = Lecture.find(params[:id])
    @user_who_commented = current_user.id
    comment = Comment.build_from(@lecture, @user_who_commented, params[:comment])
    comment.save
    redirect_to lecture_path
  end

  def download
    extension=@lecture.attachment.split('.')
    send_file Rails.root.join('public','uploads',@lecture.attachment),
    :type=>"application/#{extension[1]}", :x_sendfile=>true
  end 
  def upvote 
    @lecture = Lecture.find(params[:id])
    @lecture.upvote_by current_user
    redirect_to lecture_path
  end  
  
  def downvote
    @lecture = Lecture.find(params[:id])
    @lecture.downvote_by current_user
    redirect_to lecture_path
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture
      @lecture = Lecture.find(params[:id])
    end

    def user_is_logged_in
      if !session[:current_user]
          redirect_to user_session_path
      end
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_params
      params.require(:lecture).permit(:content, :attachment, :course_id)
    end
end
