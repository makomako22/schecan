ActiveAdmin.register AdminUser do
  permit_params :email, :username, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :current_sign_in_at
    column :created_at
    actions
  end

  filter :email
  filter :username
  filter :current_sign_in_at
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :username
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
