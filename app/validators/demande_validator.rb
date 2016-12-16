class DemandeValidator < ActiveModel::Validator
  def validate(record)
    if ( !Demande.where("groupe_id = ? AND start_date = ? AND statut = ?", record.groupe_id, record.start_date, Demande.statuts[:confirmee]).blank?)
      record.errors[:base] << "Ce groupe à déjà une demande à cette date"
    end
  end
end