ActiveAdmin.register User do
  menu :priority => 1
  permit_params :first_name, :last_name, :email, :password, :password_confirmation, :mobile, :age, :avatar, :city, :address, :provider, :uid, :oauth_token, :oauth_expires_at, :role, :confirmed_at, :confirmation_token

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

  index do
    column :first_name
    column :email
    column :mobile
    column :age
    column :city
    column :address
    column :role
    actions
  end

  show do |obj|
    attributes_table do
      row :first_name
      row :email
      row :mobile
      row :city
      row :address
      row :role
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Details" do
      f.input :first_name
      f.input :email
      f.input :mobile
      f.input :age
      f.input :city

      f.input :address
      f.input :role,:as => :select, :collection => options_for_select(['ground_owner', 'member'])

    end
    f.actions
  end
end
