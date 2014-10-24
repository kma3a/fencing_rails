class RegistrationsController < Devise::RegistrationsController

 protected

 def after_update_path_for(resource)
  coach_path(resource)
 end
end
