class Convocation < ApplicationRecord
  belongs_to :admin

  has_many :convocation_dependences
  has_many :dependences, :through => :convocation_dependences

  has_many :applications
  has_many :student, :through => :applications

  has_many :requirements
  has_many :criteria
  has_many :activities
  has_many :required_files
  has_many :profiles

  def self.search(search_params)
    
    return Convocation.joins(:dependences).where("convocations.level = (?) AND dependences.id IN (?) AND convocations.payout BETWEEN (?) AND (?) AND convocations.duration BETWEEN (?) AND (?) AND convocations.hours_per_week BETWEEN (?) AND (?)",
      search_params[:level] || "pregrado",search_params[:dependences] || Dependence.all.pluck(:id),search_params[:payout_min] || Convocation.minimum(:payout),search_params[:payout_max] || Convocation.maximum(:payout),search_params[:duration_min] || Convocation.minimum(:duration),
      search_params[:duration_max] || Convocation.maximum(:duration),search_params[:hours_per_week_min] || Convocation.minimum(:hours_per_week),search_params[:hours_per_week_max] || Convocation.maximum(:hours_per_week)).order(created_at: :desc)
    
  end

  def populate
    out_object = self.as_json
    out_object[:admin] = self.admin.populate
  end
end
