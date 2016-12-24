class Groupes::StepsControllerController < ApplicationController
  include Wicked::Wizard
  steps *Groupe.form_steps

  def show
    @groupe = Groupe.find(params[:groupe_id])
    render_wizard
  end

  def update
    @groupe = Groupe.find(params[:groupe_id])
    @groupe.update(groupe_params(step))
    render_wizard @groupe
  end

  private

  def groupe_params(step)
    permitted_attributes = case step
                           when "basics"
                             [:name, :date_de_creation,:genre,membres_attributes: [:id, :nom, :instrument, :_destroy]]
                           when "details"
                             [:avatar,:description]
                           when "preferences"
                             []
                           end

    params.require(:groupe).permit(permitted_attributes).merge(form_step: step)
  end

end
end
