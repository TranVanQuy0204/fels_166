class Word < ActiveRecord::Base
  scope:search, ->(keyword, category_id) {
    where("content LIKE ? OR category_id = ?", "%#{keyword}%", "#{category_id}")
  }
  scope:search_category, ->(category_id = 0) {
    where("category_id is null OR category_id = ?", "#{category_id}")
  }
  scope:filter_category, ->(category_id = 0){
    where("category_id = ?", "#{category_id}")
  }

  belongs_to :category
  has_many :results
  has_many :word_answers, dependent: :destroy

  accepts_nested_attributes_for :word_answers, allow_destroy: true,
    reject_if: proc {|attributes| attributes["content"].blank?}

  before_save :validate_answer_correct
  def update_category! category
    if self.results.blank?
      return self.update_attributes category_id: category.id
    end
    return false
  end

  def destroy_category!
    if self.results.blank?
      return self.update_attributes category_id: nil
    end
    return false
  end

  def destroy_word!
    if self.results.blank?
      return self.destroy
    end
    return false
  end

  def word_updates! params
    if self.results.blank?
      return self.update_attributes params
    end
    return false
  end
  private

  def validate_answer_correct
    unless self.word_answers.select{|answer| answer.is_correct}.size == 1
      self.errors.add :name, I18n.t("messages.answer_correct")
    end
  end
 end
