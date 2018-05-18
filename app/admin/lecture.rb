ActiveAdmin.register Lecture do
    permit_params :content , :attachment, :course_id
  
    index do
      selectable_column
      id_column
      column 'Content', Lecture.ids.each do |f|
        raw f.content
      end
      column :attachment
      actions
    end
  
    # filter :email
    controller do
        before_action :set_lecture, only: [ :show, :edit, :update, :destroy]

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
          format.html { redirect_to admin_lectures_path, notice: 'Lecture was successfully created.' }
        #   format.json { render :show, status: :created, location: @lecture }
        else
          format.html { render :new }
          format.json { render json: @lecture.errors, status: :unprocessable_entity }
        end
      end
    end
    def update
        uploaded_io = params[:lecture][:attachment]
        File.open(Rails.root.join('public','uploads',uploaded_io.original_filename),'wb') do |file|
       file.write(uploaded_io.read)
        end
        params[:lecture][:attachment]= uploaded_io.original_filename
    
        respond_to do |format|
    
          if @lecture.update(lecture_params)
            
            format.html { redirect_to admin_lectures_path, notice: 'Lecture was successfully updated.' }
            # format.json { render :show, status: :ok, location: @lecture }
          else
            format.html { render :edit }
            format.json { render json: @lecture.errors, status: :unprocessable_entity }
          end
        end
      end
    
    def lecture_params
        params.require(:lecture).permit(:content, :attachment, :course_id)
      end
      def set_lecture
        @lecture = Lecture.find(params[:id])
      end
end

      
    form do |f|
      f.inputs "lecture" do
        f.input :course
        f.input :content
        f.input :attachment, :as => :file
      end
      f.actions
    end

    show do |lecture|
        lecture.content
        lecture.attachment

    end
  
  end