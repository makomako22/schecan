ActiveAdmin.register User do
permit_params :email, :username, :role, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :role
    column :current_sign_in_at
    column :created_at
    actions
  end

  filter :email
  filter :username
  filter :role
  filter :current_sign_in_at
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :username
      f.input :role
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
