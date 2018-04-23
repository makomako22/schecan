class Student < ActiveRecord::Base
  
  validates_presence_of :term, :base_id, :family_name, :first_name, :family_name_kana, :first_name_kana
  has_many :schedules, dependent: :destroy
  belongs_to :base
  
  def name
    "#{family_name} #{first_name}"
  end

  def name_kana
    "#{family_name_kana} #{first_name_kana}"
  end

  def get_student_term(student)
    s_term = student.term
    term = Term.find_by(term_i: s_term)
    term.term_t
  end

end
