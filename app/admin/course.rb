ActiveAdmin.register Course do
    permit_params :title
  
    index do
      selectable_column
      id_column
      column :title
      column :created_at
      actions
    end
  
    filter :email
   
  
    # form do |f|
    #   f.inputs "Admin Details" do
    #     f.input :email
    #     f.input :password
    #     f.input :password_confirmation
    #   end
    #   f.actions
    # end
    show do |course|
        course.title
    end
  
  end