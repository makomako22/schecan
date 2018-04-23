class Term < ActiveRecord::Base

  validates_presence_of :term_i, :term_t

  def student_count(term)
    student = Student.where(term: term.term_i)
    student.count
  end
  
end
