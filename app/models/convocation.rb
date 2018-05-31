class Convocation < ApplicationRecord
  belongs_to :admin

  has_many :convocation_dependences, dependent: :destroy
  has_many :dependences, :through => :convocation_dependences

  has_many :applications, dependent: :destroy
  has_many :users, :through => :applications

  has_many :requirements, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :required_files, dependent: :destroy
  has_many :profiles, dependent: :destroy

  accepts_nested_attributes_for :requirements
  accepts_nested_attributes_for :activities
  accepts_nested_attributes_for :required_files
  accepts_nested_attributes_for :profiles
  accepts_nested_attributes_for :convocation_dependences

  def self.search(search_params)
    return Convocation.joins(:dependences).where("convocations.level = (?) AND dependences.id IN (?) AND convocations.payout BETWEEN (?) AND (?) AND convocations.duration BETWEEN (?) AND (?) AND convocations.hours_per_week BETWEEN (?) AND (?)",
      search_params[:level] || "pregrado",search_params[:dependences] || Dependence.all.pluck(:id),search_params[:payout_min] || Convocation.minimum(:payout),search_params[:payout_max] || Convocation.maximum(:payout),search_params[:duration_min] || Convocation.minimum(:duration),
      search_params[:duration_max] || Convocation.maximum(:duration),search_params[:hours_per_week_min] || Convocation.minimum(:hours_per_week),search_params[:hours_per_week_max] || Convocation.maximum(:hours_per_week)).distinct.order(created_at: :desc)
  end
  
  def self.most_wanted
    out_obj = []
    Application.joins(:user).group(:convocation_id).paginate(:page=>1,:per_page=>10).each do |app|
      out_obj.push(:name => app.convocation.name,:count => Application.joins(:user).group(:convocation_id).count[app.convocation.id])
    end
    return out_obj
  end

  def populate
    out_object = self.as_json
    out_object[:dependences] = self.dependences.as_json
    out_object[:requirements] = self.requirements.as_json
    out_object[:required_files] = self.required_files.as_json
    out_object[:profiles] = self.profiles.as_json
    out_object[:activities] = self.activities.as_json
    out_object[:admin] = self.admin.populate

    return out_object
  end
  
  def populate_for_admin
    out_object = self.as_json
    out_object[:approved] = self.applications.where(state:'aprobado').map { |x| x.user.as_json.merge(:application_id => x.id,:state => x.state) }
    out_object[:interested] = self.applications.where(state:'interesado').map { |x| x.user.as_json.merge(:application_id => x.id,:state => x.state) }
    out_object[:rejected] = self.applications.where(state:'rechazado').map { |x| x.user.as_json.merge(:application_id => x.id,:state => x.state) }
    
    out_object[:dependences] = self.dependences.as_json
    out_object[:requirements] = self.requirements.as_json
    out_object[:required_files] = self.required_files.as_json
    out_object[:profiles] = self.profiles.as_json
    out_object[:activities] = self.activities.as_json
    return out_object
  end

end
