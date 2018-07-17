ActiveAdmin.register Term do
	permit_params :term_i, :term_t
index do
    selectable_column
    id_column
    column :term_i
    column :term_t
    column :created_at
    actions
  end

  filter :term_i
  filter :term_t
  filter :created_at

  form do |f|
    f.inputs do
      f.input :term_i
      f.input :term_t
    end
    f.actions
  end
end
