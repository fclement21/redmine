class RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!, :redirect_unless_admin, :except => [:edit]
  prepend_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy]



def create
  @user = User.create
    build_resource
    respond_to do |format|
      format.html {redirect_to :controller => 'users', :action => 'index'}
      format.js
    end
    if resource.save
      redirect_to users_index_path
       flash[:succes] = "Utilisateur cree"
    else
      clean_up_passwords resource
      respond_with resource
      flash[:avertissement] = "Veuillez remplir tout les champs."

    end
  end


def new
  @user = User.new

end

  def destroy

    @user = User.find(params[:id])
    @user.destroy

    redirect_to :controller =>'users', :action =>'index'
       flash[:succes] = "User supprime"


    end

    private
def redirect_unless_admin
  unless current_user.admin?
    redirect_to root_path
  end
end

end

